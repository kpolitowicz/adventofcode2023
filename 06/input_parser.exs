Code.require_file "race.exs", __DIR__

defmodule InputParser do
  # e.g.
  # Time:      7  15   30
  # Distance:  9  40  200
  #
  def parse(input) do
    [times | [distances | _]] = input

    Enum.zip(extract_nums(times), extract_nums(distances))
    |> Enum.map(fn {time, dist} -> %Race{time: time, distance: dist} end)
  end

  def parse_ignoring_kerning(input) do
    [times | [distances | _]] = input

    [%Race{
      time: concat_nums(times),
      distance: concat_nums(distances),
    }]
  end

  defp extract_nums(line) do
    [_, nums] =
      String.split(line, ":")

    String.split(nums, ~r/\s+/, trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp concat_nums(line) do
    [_, nums] =
      String.split(line, ":")

    String.replace(nums, ~r/\s+/, "") |> String.to_integer()
  end
end
