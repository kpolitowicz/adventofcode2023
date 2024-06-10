ExUnit.start

Code.require_file "engine_schematic.exs", __DIR__

defmodule EngineSchematicTest do
  use ExUnit.Case

  test "Number should know if it is adjacent to any of the symbols" do
    symbols = [
      %Symbol{s: "x", pos: %Coord{r: 1, c: 3}},
      %Symbol{s: "#", pos: %Coord{r: 3, c: 6}},
      %Symbol{s: "*", pos: %Coord{r: 4, c: 3}},
      %Symbol{s: "+", pos: %Coord{r: 5, c: 5}},
      %Symbol{s: "$", pos: %Coord{r: 8, c: 3}},
      %Symbol{s: "*", pos: %Coord{r: 8, c: 5}},
    ]
    adjacent_num = %Number{n: 633, len: 3, pos: %Coord{r: 2, c: 6}}
    not_adjacent_num = %Number{n: 114, len: 3, pos: %Coord{r: 0, c: 5}}

    assert Number.adjacent?(adjacent_num, symbols)
    refute Number.adjacent?(not_adjacent_num, symbols)
  end
end
