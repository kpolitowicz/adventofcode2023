Code.require_file "engine_schematic.exs", __DIR__

defmodule Solver do
  def part1(schematic) do
    schematic.numbers
    |> Enum.filter(fn num ->
      Number.adjacent?(num, schematic.symbols)
    end)
    |> Enum.reduce(0, fn num, acc -> acc + num.n end)
  end

  def part2(schematic) do
    schematic.symbols
    |> Enum.filter(fn sym -> sym.s == "*" end)
    |> Enum.map(fn sym -> Symbol.adjacent_numbers(sym, schematic.numbers) end)
    |> Enum.filter(fn adj_list -> length(adj_list) == 2 end)
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end
end
