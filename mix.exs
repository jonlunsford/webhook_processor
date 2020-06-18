# ./mix.exs
defmodule WebhookProcessor.MixProject do
  use Mix.Project

  def project do
    [
      app: :webhook_processor,
      version: "0.2.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        prod: [
          include_executables_for: [:unix], # we'll be deploying to Linux only
          steps: [:assemble, :tar] # have Mix automatically create a tar after assembly
        ]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # Add :plug_cowboy to extra_applications
      extra_applications: [:logger, :plug_cowboy],
      mod: {WebhookProcessor.Application, []}
    ]
  end

  # ./mix.exs

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.1"}, # This will pull in Plug AND Cowboy
      {:poison, "~> 4.0"}, # Latest version as of this writing
    ]
  end
end
