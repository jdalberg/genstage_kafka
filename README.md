# genstage_kafka
A GenStage consumer, that will sink its events into a Kafka producer

## Example of use

In a GenStage chain, you can start this module as you would a "normal" GenStage
consumer by use of the GenStageKafka.start_link(kafkaOptions)

The kafkaOptions currently handled are (with defaults given):

  :hosts - [localhost: 9092]
  :topics - "no_topic"
  :partition - 0


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `genstage_kafka` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:genstage_kafka, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/kafka_genstage](https://hexdocs.pm/kafka_genstage).

