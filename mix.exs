defmodule Islands.Client.Summary.MixProject do
  use Mix.Project

  def project do
    [
      app: :islands_client_summary,
      version: "0.1.17",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      name: "Islands Client Summary",
      source_url: source_url(),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  defp source_url do
    "https://github.com/RaymondLoranger/islands_client_summary"
  end

  defp description do
    """
    Displays the summary of a Game of Islands.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "config/persist*.exs"],
      maintainers: ["Raymond Loranger"],
      licenses: ["MIT"],
      links: %{"GitHub" => source_url()}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Islands.Client.Summary.App, :ok}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:io_ansi_plus, "~> 0.1"},
      {:io_ansi_table, "~> 1.0"},
      {:islands_client_island_type, "~> 0.1"},
      {:islands_client_state, "~> 0.1"},
      {:islands_coord, "~> 0.1"},
      {:islands_grid, "~> 0.1"},
      {:islands_island, "~> 0.1"},
      {:islands_player, "~> 0.1"},
      {:islands_response, "~> 0.1"},
      {:islands_score, "~> 0.1"},
      {:islands_tally, "~> 0.1"},
      {:mix_tasks,
       github: "RaymondLoranger/mix_tasks", only: :dev, runtime: false},
      {:persist_config, "~> 0.4", runtime: false}
    ]
  end
end
