defmodule Mix.Tasks.Ansible.Playbook do
  use Mix.Task

  @shortdoc "Run ansible playbooks"
  def run(args) do
    Mix.Task.run("ansible", args)
  end
end
