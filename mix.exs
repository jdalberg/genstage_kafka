defmodule GenStageKafka.Mixfile do
  use Mix.Project

  def project do
    [app: :genstage_kafka,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     name: "GenStageKafka",
     source_url: "https://github.com/jdalberg/genstage_kafka",
     deps: deps()]
  end

  def application do
    []
  end

  defp description do
    """
    A module that makes a GenStage producer publish to a kafka topic
    """
  end

  defp package do
    [
      name: :genstage_kafka,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Jesper Dalberg"],
      licenses: ["The Unlicense"],
      links: %{"GitHub" => "https://github.com/jdalberg/genstage_kafka"}
    ]
  end

  defp deps do
    [
      {:gen_stage, "~> 0.11.0"},
      {:brod, "~> 2.3.6"},
      {:ex_doc, "~> 0.14", only: :dev}
    ]
  end
end
