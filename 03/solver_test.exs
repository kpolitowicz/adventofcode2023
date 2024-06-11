ExUnit.start

Code.require_file "solver.exs", __DIR__

defmodule SolverTest do
  use ExUnit.Case

  test "sums the numbers adjacent to symbols for part 1" do
    schematic = %EngineSchematic{
      numbers: [
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
      ],
      symbols: [
        %Symbol{s: "*", pos: %Coord{r: 1, c: 3}},
        %Symbol{s: "#", pos: %Coord{r: 3, c: 6}},
        %Symbol{s: "*", pos: %Coord{r: 4, c: 3}},
        %Symbol{s: "+", pos: %Coord{r: 5, c: 5}},
        %Symbol{s: "$", pos: %Coord{r: 8, c: 3}},
        %Symbol{s: "*", pos: %Coord{r: 8, c: 5}},
      ]
    }

    assert 4361 = Solver.part1(schematic)
  end

  test "sums the gear ratios for part 2" do
    schematic = %EngineSchematic{
      numbers: [
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
      ],
      symbols: [
        %Symbol{s: "*", pos: %Coord{r: 1, c: 3}},
        %Symbol{s: "#", pos: %Coord{r: 3, c: 6}},
        %Symbol{s: "*", pos: %Coord{r: 4, c: 3}},
        %Symbol{s: "+", pos: %Coord{r: 5, c: 5}},
        %Symbol{s: "$", pos: %Coord{r: 8, c: 3}},
        %Symbol{s: "*", pos: %Coord{r: 8, c: 5}},
      ]
    }

    assert 467835 = Solver.part2(schematic)
  end
end
