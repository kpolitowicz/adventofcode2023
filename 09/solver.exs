Code.require_file "history_forecast.exs", __DIR__

defmodule Solver do
  def part1(history) do
    history
    |> Enum.map(&HistoryForecast.next_value/1)
    |> Enum.sum
  end

  def part2(history) do
    history
    |> Enum.map(&HistoryForecast.past_value/1)
    |> Enum.sum
  end
end
