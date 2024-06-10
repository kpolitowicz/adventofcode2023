Code.require_file "engine_schematic.exs", __DIR__

defmodule Solver do
  def part1(schematic) do
    schematic.numbers
    |> Enum.filter(fn num ->
      Number.adjacent?(num, schematic.symbols)
    end)
    |> Enum.reduce(0, fn num, acc -> acc + num.n end)
  end
end
