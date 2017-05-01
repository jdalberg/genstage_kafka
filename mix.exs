defmodule GenStageKafka.Mixfile do
  use Mix.Project

  def project do
    [app: :genstage_kafka,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:gen_stage, "~> 0.11.0"},
      {:brod, "~> 2.3.6"}
    ]
  end
end
