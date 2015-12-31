defmodule ElixirV8.Mixfile do
  use Mix.Project

  def project do
    [app: :elixir_v8,
     version: "0.2.1",
     elixir: "~> 1.1",
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
      { :poolboy, github: "devinus/poolboy" },
      { :exjsx, github: "talentdeficit/jsex" }
    ]
  end
end
