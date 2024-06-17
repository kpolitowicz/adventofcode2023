ExUnit.start

Code.require_file "input_parser.exs", __DIR__

defmodule InputParserTest do
  use ExUnit.Case

  test "parses input into list of hands" do
    input = [
      "0 3 6 9 12 15",
      "1 3 6 10 15 21",
      "10 13 16 21 30 45",
    ]
    expected = [
      [0, 3, 6, 9, 12, 15],
      [1, 3, 6, 10, 15, 21],
      [10, 13, 16, 21, 30, 45]
    ]

    assert ^expected = InputParser.parse(input)
  end
end
