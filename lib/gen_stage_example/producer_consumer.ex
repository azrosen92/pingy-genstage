defmodule GenStageExample.ProducerConsumer do
    use GenStage

    def init(_) do
        {:producer_consumer, :ok}
    end

    def handle_events(urls, _from, _state) do
        statuses = urls
        |> Stream.map(fn(url) ->
            IO.puts "getting url: " <> url
            url |> HTTPotion.get |> HTTPotion.Response.success?
        end)

        {:noreply, statuses, :ok}
    end
end