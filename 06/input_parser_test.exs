ExUnit.start

Code.require_file "input_parser.exs", __DIR__

defmodule InputParserTest do
  use ExUnit.Case

  test "parses input into list of races" do
    input = [
      "Time:      7  15   30",
      "Distance:  9  40  200",
    ]
    expected = [
      %Race{time: 7, distance: 9},
      %Race{time: 15, distance: 40},
      %Race{time: 30, distance: 200},
    ]

    assert ^expected = InputParser.parse(input)
  end

  test "fixes the bad kerning when parsing" do
    input = [
      "Time:      7  15   30",
      "Distance:  9  40  200",
    ]
    expected = [
      %Race{time: 71530, distance: 940200},
    ]

    assert ^expected = InputParser.parse_ignoring_kerning(input)
  end
end
