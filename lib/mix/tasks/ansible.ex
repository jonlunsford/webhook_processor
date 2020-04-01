defmodule Mix.Tasks.Ansible do
  use Mix.Task

  @shortdoc "Run ansible playbooks"
  def run([playbook | app_version]) do
    cmd_args = ["./ansible/tasks/#{playbook}.yml"]
    app_version = if app_version == "", do: app_vsn(), else: List.first(app_version)

    System.cmd(
      "ansible-playbook",
      cmd_args,
      env: [
        {"ANSIBLE_CONFIG", "./ansible/ansible.cfg"},
        {"APP_NAME", app_name()},
        {"APP_VSN", app_version},
        {"APP_PORT", app_port()},
        {"APP_LOCAL_RELEASE_PATH",
         "#{Mix.Project.build_path()}/rel/#{app_name()}/releases/#{app_version}"}
      ],
      into: IO.stream(:stdio, :line)
    )
  end

  defp app_name do
    Mix.Project.config()[:app]
    |> Atom.to_string()
  end

  defp app_vsn do
    Mix.Project.config()[:version]
  end

  defp app_port do
    Application.get_env(:webhook_processor, :port)
    |> Integer.to_string()
  end
end
