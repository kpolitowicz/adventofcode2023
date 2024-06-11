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

  test "Symbol should list all their adjacent part numbers" do
    numbers = [
      %Number{n: 467, len: 3, pos: %Coord{r: 0, c: 0}},
      %Number{n: 114, len: 3, pos: %Coord{r: 0, c: 5}},
      %Number{n: 35, len: 2, pos: %Coord{r: 2, c: 2}},
      %Number{n: 633, len: 3, pos: %Coord{r: 2, c: 6}},
      %Number{n: 617, len: 3, pos: %Coord{r: 4, c: 0}},
      %Number{n: 58, len: 2, pos: %Coord{r: 5, c: 7}},
      %Number{n: 592, len: 3, pos: %Coord{r: 6, c: 2}},
      %Number{n: 755, len: 3, pos: %Coord{r: 7, c: 6}},
      %Number{n: 664, len: 3, pos: %Coord{r: 9, c: 1}},
      %Number{n: 598, len: 3, pos: %Coord{r: 9, c: 5}},
    ]

    assert [467, 35] = Symbol.adjacent_numbers(%Symbol{s: "*", pos: %Coord{r: 1, c: 3}}, numbers)
    assert [617] = Symbol.adjacent_numbers(%Symbol{s: "*", pos: %Coord{r: 4, c: 3}}, numbers)
    assert [755, 598] = Symbol.adjacent_numbers(%Symbol{s: "*", pos: %Coord{r: 8, c: 5}}, numbers)
  end
end
