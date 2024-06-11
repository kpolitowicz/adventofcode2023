defmodule Coord do
  defstruct [:r, :c]
end

defmodule Number do
  defstruct [:n, :len, :pos]

  def adjacent?(num, symbols) do
    # say we have %Number{n: 467, len: 3, pos: %Coord{r: 0, c: 0}}
    # we're looking for a symbol with:
    # -1 <= pos.r <= 1
    # -1 <= pos.c <= 3 (because number is of len 3)
    num_box = %{
      ul: %Coord{
        r: num.pos.r - 1,
        c: num.pos.c - 1,
      },
      lr: %Coord{
        r: num.pos.r + 1,
        c: num.pos.c + num.len,
      }
    }

    Enum.any?(symbols, fn symbol ->
      symbol.pos.r >= num_box.ul.r and
      symbol.pos.r <= num_box.lr.r and
      symbol.pos.c >= num_box.ul.c and
      symbol.pos.c <= num_box.lr.c
    end)
  end
end

defmodule Symbol do
  defstruct [:s, :pos]

  def adjacent_numbers(sym, numbers) do
    # say we have a symbol %Symbol{s: "*", pos: %Coord{r: 1, c: 3}}
    # we're looking for any number that touches it, but it gets tricky for
    # double- and triple-digit numbers.
    # So, we will be looking for any number in adjacent rows (0 <= pos.r <= 2)
    # and then filter in only the numbers with pos.c "touching" 3.
    numbers
    |> Enum.filter(fn num ->
      num.pos.r >= (sym.pos.r - 1) and
      num.pos.r <= (sym.pos.r + 1)
    end)
    |> Enum.filter(fn num ->
      Number.adjacent?(num, [sym])
    end)
    |> Enum.map(& &1.n)
  end
end

defmodule EngineSchematic do
  defstruct numbers: [], symbols: []
end
