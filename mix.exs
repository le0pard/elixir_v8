defmodule ElixirV8.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_v8,
     version: "0.2.2",
     elixir: "~> 1.2",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {ElixirV8, []},
      applications: [:kernel, :stdlib, :erlang_v8]
    ]
  end

  defp description do
    """
    V8 engine for Elixir with pools.
    """
  end

  defp package do
    [
      files: ["lib", "test", "mix.exs", "README.md"],
      maintainers: ["Alexey Vasiliev"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/le0pard/elixir_v8",
        "Docs" => "http://leopard.in.ua/elixir_v8/"
      }
    ]
  end

  # Dependencies can be hex.pm packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      { :erlang_v8, github: "strange/erlang-v8" },
      { :poolboy, "~> 1.5" },
      { :exjsx, "~> 3.2" }
    ]
  end
end
