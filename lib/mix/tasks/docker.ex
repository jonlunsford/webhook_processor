# ./lib/mix/taks/docker.ex
defmodule Mix.Tasks.Docker do
  use Mix.Task

  @shortdoc "Docker utilities for building releases"
  def run(["release"]) do
    # Build a fresh Elixir image, in case Dockerfile has changed
    docker("build -t elixir-ubuntu:latest .")

    # Get the current working directory
    {dir, _resp} = System.cmd("pwd", [])

    # Mount the working directory at /opt/build within the new elixir image
    # Pass in the rel/bin/release script that will run distillery
    docker(
      "run -v #{String.trim(dir)}:/opt/build --rm -i elixir-ubuntu:latest /opt/build/rel/bin/release"
    )
  end

  def run(["upgrade"]) do
    # Build a fresh Elixir image, in case Dockerfile has changed
    docker("build -t elixir-ubuntu:latest .")

    # Get the current working directory
    {dir, _resp} = System.cmd("pwd", [])

    # Mount the working directory at /opt/build within the new elixir image
    # Pass in the rel/bin/release script that will run distillery with the --upgrade flag
    docker(
      "run -v #{String.trim(dir)}:/opt/build --rm -i elixir-ubuntu:latest /opt/build/rel/bin/release --upgrade"
    )
  end

  defp docker(cmd) do
    System.cmd("docker", String.split(cmd, " "), into: IO.stream(:stdio, :line))
  end
end
