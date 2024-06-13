Code.require_file "almanac.exs", __DIR__

defmodule Solver do
  def part1(almanac) do
    almanac.seeds
    |> Enum.map(fn seed ->
      Almanac.seed_location(almanac, seed)
    end)
    |> Enum.min
  end

  def part2(almanac) do
    seed_ranges =
      almanac.seeds
      |> Enum.chunk_every(2)
      |> Enum.map(fn [start, len] ->
        Range.new(start, start + len - 1)
      end)

    min.._//_ = Almanac.seed_range_locations(almanac, seed_ranges)
    |> Enum.sort()
    |> Enum.at(0)

    min
  end
end
