defmodule Exred.Node.Shell.Mixfile do
  use Mix.Project

  def project do
    [
      app: :exred_node_shell,
      version: "0.1.6",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp aliases do
    [
      test: "test --no-start"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:exred_library, git: "git@bitbucket.org:zsolt001/exred_library.git"},
      {:porcelain, "~> 2.0"}
    ]
  end
end
