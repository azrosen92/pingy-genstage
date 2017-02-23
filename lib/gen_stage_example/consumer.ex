defmodule GenStageExample.Consumer do
    use GenStage

    def init(sleeping_time) do
        {:consumer, sleeping_time}
    end

    def handle_events(events, _from, sleeping_time) do
        IO.inspect(events)
        Process.sleep(sleeping_time)
        
        events
        |> Enum.map(&IO.puts/1)

        {:noreply, [], sleeping_time}
    end
end