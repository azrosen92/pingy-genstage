defmodule GenStageExample.ProducerConsumer do
    use GenStage

    def init(_) do
        {:producer_consumer, :ok}
    end

    def handle_events(urls, _from, _state) do
        statuses = urls
        |> Stream.map(fn(url) ->
            status = url |> HTTPotion.get |> status_code
            %{ :website => url, :status => status }
        end)

        {:noreply, statuses |> Enum.to_list, :ok}
    end

    defp status_code(response) do
        case response do
            %HTTPotion.Response{body: _, headers: _, status_code: status_code} ->
                status_code
            _ -> 500
        end
    end
end