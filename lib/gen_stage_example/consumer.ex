defmodule GenStageExample.Consumer do
    use GenStage

    def init(sleeping_time) do
        {:consumer, sleeping_time}
    end

    def handle_events(events, _from, sleeping_time) do
        events
        |> Enum.each(&IO.inspect/1)

        {:noreply, [], sleeping_time}
    end
end