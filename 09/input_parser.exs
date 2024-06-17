defmodule InputParser do
  # e.g.
  # 0 3 6 9 12 15
  # 1 3 6 10 15 21
  # 10 13 16 21 30 45
  #
  def parse(input) do
    input
    |> Enum.map(fn line ->
      String.split(line, " ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
