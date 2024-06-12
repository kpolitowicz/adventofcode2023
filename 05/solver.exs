Code.require_file "almanac.exs", __DIR__

defmodule Solver do
  def part1(almanac) do
    almanac.seeds
    |> Enum.map(fn seed ->
      Almanac.seed_location(almanac, seed)
    end)
    |> Enum.min
  end
end
