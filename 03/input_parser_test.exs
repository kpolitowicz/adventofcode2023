ExUnit.start

Code.require_file "input_parser.exs", __DIR__

defmodule InputParserTest do
  use ExUnit.Case

  test "parses engine schematic input into a EngineSchematic struct" do
    input = [
      "467..114..",
      "...*......",
      "..35..633.",
      "......#...",
      "617*......",
      ".....+.58.",
      "..592.....",
      "......755.",
      "...$.*....",
      ".664.598..",
    ]
    expected = %EngineSchematic{
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

    assert ^expected = InputParser.parse(input)
  end

  test "parses input to indexed grid (map of maps)" do
    input = [
      "46",
      "..",
    ]
    expected = [
      {
        [{"4", 0}, {"6", 1}],
        0
      },
      {
        [{".", 0}, {".", 1}],
        1
      }
    ]

    assert ^expected = InputParser.parse_to_grid(input)
  end

  test "extracts numbers with positions from the grid" do
    grid = [
      {
        [{".", 0}, {"4", 1}, {"1", 2}],
        0
      },
      {
        [{".", 0}, {"5", 1}, {".", 2}],
        1
      }
    ]
    expected = [
      %Number{n: 41, len: 2, pos: %Coord{r: 0, c: 1}},
      %Number{n: 5, len: 1, pos: %Coord{r: 1, c: 1}},
    ]

    assert ^expected = InputParser.parse_numbers(grid)
  end

  test "extracts symbols with positions from the grid" do
    grid = [
      {
        [{".", 0}, {"$", 1}],
        0
      },
      {
        [{"+", 0}, {".", 1}],
        1
      }
    ]
    expected = [
      %Symbol{s: "$", pos: %Coord{r: 0, c: 1}},
      %Symbol{s: "+", pos: %Coord{r: 1, c: 0}},
    ]

    assert ^expected = InputParser.parse_symbols(grid)
  end
end
