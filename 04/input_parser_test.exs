ExUnit.start

Code.require_file "input_parser.exs", __DIR__

defmodule InputParserTest do
  use ExUnit.Case

  test "parses card info into Card list" do
    input = [
      "Card  1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53",
      "Card  2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19",
      "Card  3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1",
      "Card  4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83",
      "Card  5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36",
      "Card  6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11",
    ]
    expected = [
      %Card{id: 1, winning: [41, 48, 83, 86, 17], mine: [83, 86,  6, 31, 17,  9, 48, 53]},
      %Card{id: 2, winning: [13, 32, 20, 16, 61], mine: [61, 30, 68, 82, 17, 32, 24, 19]},
      %Card{id: 3, winning: [ 1, 21, 53, 59, 44], mine: [69, 82, 63, 72, 16, 21, 14,  1]},
      %Card{id: 4, winning: [41, 92, 73, 84, 69], mine: [59, 84, 76, 51, 58,  5, 54, 83]},
      %Card{id: 5, winning: [87, 83, 26, 28, 32], mine: [88, 30, 70, 12, 93, 22, 82, 36]},
      %Card{id: 6, winning: [31, 18, 13, 56, 72], mine: [74, 77, 10, 23, 35, 67, 36, 11]},
    ]

    assert ^expected = InputParser.parse(input)
  end
end
