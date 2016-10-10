defmodule Icndb.Mixfile do
  use Mix.Project

  def project do
    [app: :icndb,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     escript: [main_module: Icndb.CLI],
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison, :exconstructor]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9.2"},
      {:poison, "~> 3.0"},
      {:exconstructor, "~> 1.0.2"},
      {:exvcr, "~> 0.7", only: :test},
      {:credo, "~> 0.4", only: [:dev, :test]}
    ]
  end
end
