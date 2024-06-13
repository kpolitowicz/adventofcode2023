Code.require_file "race.exs", __DIR__

defmodule Solver do
  def part1(races) do
    races
    |> Enum.map(&Race.ways_to_win/1)
    |> Enum.product
  end
end
