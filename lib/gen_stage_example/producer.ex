defmodule GenStageExample.Producer do
    use GenStage

    def init(line \\ 0) do
        {:producer, line}
    end

    def handle_demand(demand, line) when demand > 0 do
        File.open("websites.txt")
        |> case do
            {:ok, file_device} ->
                urls = file_device |> IO.stream(:line) |> fetch_lines(line, line+demand)
                {:noreply, urls, line + demand + 1}
            {:error, reason} ->
                IO.puts "Could not open file"
                {:noreply, [], line}
        end
    end

    defp fetch_lines(stream, start_line, end_line) do
        stream 
        |> Stream.with_index
        |> Stream.filter_map(fn ({_, index}) -> 
            index >= start_line && index < end_line
        end, fn ({line, _}) -> 
            line |> String.trim("\n")
        end)
        |> Enum.to_list
    end
end