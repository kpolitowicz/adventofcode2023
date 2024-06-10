Code.require_file "engine_schematic.exs", __DIR__

defmodule InputParser do
  # e.g. 10x10
  #
  # 467..114..
  # ...*......
  # ..35..633.
  # ......#...
  # 617*......
  # .....+.58.
  # ..592.....
  # ......755.
  # ...$.*....
  # .664.598..
  #
  def parse(input) do
    grid = parse_to_grid(input)

    %EngineSchematic{
      numbers: parse_numbers(grid),
      symbols: parse_symbols(grid),
    }
  end

  def parse_to_grid(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {line, row} ->
      {
        line
        |> String.split("", trim: true)
        |> Enum.with_index(),
        row
      }
    end)
  end

  def parse_numbers(grid) do
    grid
    |> Enum.reduce([], fn {line, row}, acc ->
      line
      |> Enum.reduce(acc, fn {chr, col}, acc ->
        cond do
          String.match?(chr, ~r/\d/) -> [%Number{n: chr, len: 1, pos: %Coord{r: row, c: col}} | acc]
          true -> acc
        end
      end)
    end)
    |> consolidate_numbers()
    |> convert_to_int()
    # |> Enum.reverse()
  end

  def parse_symbols(grid) do
    grid
    |> Enum.reduce([], fn {line, row}, acc ->
      line
      |> Enum.reduce(acc, fn {chr, col}, acc ->
        cond do
          String.match?(chr, ~r/[\d\.]/) -> acc
          true -> [%Symbol{s: chr, pos: %Coord{r: row, c: col}} | acc]
        end
      end)
    end)
    |> Enum.reverse()
  end

  defp consolidate_numbers(numbers) do
    numbers
    |> Enum.reduce([], fn num, acc ->
      concat_num(num, acc)
    end)
  end

  defp concat_num(num, []), do: [num]
  defp concat_num(num, [last | rest] = acc) do
    if num.pos.r == last.pos.r and num.pos.c == (last.pos.c - 1) do
      new_num = %Number{
        n: num.n <> last.n,
        len: last.len + 1,
        pos: num.pos,
      }
      [new_num | rest]
    else
      [num | acc]
    end
  end

  defp convert_to_int(numbers) do
    numbers
    |> Enum.map(fn num ->
      Map.update!(num, :n, &String.to_integer/1)
    end)
  end
end
