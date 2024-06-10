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
end

defmodule EngineSchematic do
  defstruct numbers: [], symbols: []
end
