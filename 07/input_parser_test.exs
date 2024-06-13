ExUnit.start

Code.require_file "input_parser.exs", __DIR__

defmodule InputParserTest do
  use ExUnit.Case

  test "parses input into list of hands" do
    input = [
      "32T3K 765",
      "T55J5 684",
      "KK677 28",
      "KTJJT 220",
      "QQQJA 483",
    ]
    expected = [
      %Hand{cards: "32T3K", bid: 765},
      %Hand{cards: "T55J5", bid: 684},
      %Hand{cards: "KK677", bid: 28},
      %Hand{cards: "KTJJT", bid: 220},
      %Hand{cards: "QQQJA", bid: 483},
    ]

    assert ^expected = InputParser.parse(input)
  end
end
