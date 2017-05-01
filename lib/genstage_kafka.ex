defmodule GenStageKafka do
  use GenStage

  @kafka_client_id :gs_kafka_producer_client

  @moduledoc """

  A module that is a GenStage Consumer, and publishes the records received
  into a Kafka topic

  """

  @doc """

  Starts the GenStageKafka with the options.

  The options handled by the module arei (defaults shown).

  :hosts - [localhost: 9092]
  :topic - "no_topic"
  :partition - 0

  Given as a keyword lists, i.e.

  KafkaGenStage.start_link( topic: "my_topic", hosts: [my_broker.example.com: 9092] )

  """
  def start_link( kafka_options ) do
    GenStage.start_link( GenStageKafka, kafka_options )
  end

  @doc """

  The init function for the GenStage server.

  Setup the Kafka produce and indicate that we are a GenStage consumer

  """
  def init(kafka_options) do
    # Setup the kafka producer.
    bootstrapProducer( kafka_options )

    # Indicate that we are a GenStage consumer
    {:consumer, %{kafka_options: kafka_options}}
  end

  @doc """

  The GenStage consumer event handler.

  The events have to be a list of maps where each map
  has 'key' and 'value'. Every map that conforms to these
  requirements are produced to the configured kafka partition

  """
  def handle_events(events, _from, state) do
    # Produce to kafka
    results = Enum.map(events, fn(e) ->
      case e do
        %{key: key, value: value} ->
          :brod.produce_sync(@kafka_client_id, state.kafka_options[:topic], state.kafka_options[:partition], key, value)
        _ ->
          :error_invalid_data
      end
    end)

    # We are a consumer, so we would never emit items.
    {:noreply, [], state}
  end

  defp bootstrapProducer(kafka_options) do
    hosts = Keyword.get(kafka_options, :host, [localhost: 9092])
    topic = Keyword.get(kafka_options, :topic, "no_topic")

    :ok = :brod.start_client(hosts, @kafka_client_id, _client_config=[])
    :ok = :brod.start_producer(@kafka_client_id, [topic], _producer_config=[])
  end

end
