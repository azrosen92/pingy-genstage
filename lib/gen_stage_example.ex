# http://www.elixirfbp.org/2016/07/genstage-example.html
defmodule GenStageExample do    
    def start(_type, _args) do
        {:ok, producer} = GenStage.start_link(GenStageExample.Producer, 0)
        {:ok, producer_consumer} = GenStage.start_link(GenStageExample.ProducerConsumer, :ok)
        {:ok, consumer} = GenStage.start_link(GenStageExample.Consumer, :ok)

        GenStage.sync_subscribe(consumer, to: producer_consumer, max_demand: 10)
        GenStage.sync_subscribe(producer_consumer, to: producer)

        Process.sleep(:infinity)
    end
end