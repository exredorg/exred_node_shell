defmodule Exred.Node.Shell.Mixfile do
  use Mix.Project

  @description "Runs shell commands"
  @version File.read!("VERSION") |> String.trim()

  def project do
    [
      app: :exred_node_shell,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: @description,
      package: package(),
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
      {:ex_doc, "~> 0.19.0", only: :dev, runtime: false},
      {:exred_nodeprototype, "~> 0.2"},
      {:porcelain, "~> 2.0"}
    ]
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Zsolt Keszthelyi"],
      links: %{
        "GitHub" => "https://github.com/exredorg/exred_node_shell.git",
        "Exred" => "http://exred.org"
      },
      files: ["lib", "mix.exs", "README.md", "LICENSE", "VERSION"]
    }
  end
end
