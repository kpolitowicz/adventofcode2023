defmodule HistoryForecast do
  def next_value(values) do
    resolve_diffs([values])
    |> forecast_last_value(0)
  end

  def past_value(values) do
    resolve_diffs([values])
    |> forecast_past_value(0)
  end

  defp resolve_diffs(values) do
    [last_row | _] = values

    cond do
      Enum.all?(last_row, fn v -> v == 0 end) -> values
      true ->
        new_row =
          Range.new(0, length(last_row) - 2)
          |> Enum.map(fn idx -> Enum.at(last_row, idx + 1) - Enum.at(last_row, idx) end)

        resolve_diffs([new_row | values])
    end
  end

  defp forecast_last_value([], forecast), do: forecast
  defp forecast_last_value(values, forecast) do
    [last_row | rest] = values

    forecast_last_value(rest, Enum.at(last_row, -1) + forecast)
  end

  defp forecast_past_value([], forecast), do: forecast
  defp forecast_past_value(values, forecast) do
    [last_row | rest] = values

    forecast_past_value(rest, Enum.at(last_row, 0) - forecast)
  end
end
