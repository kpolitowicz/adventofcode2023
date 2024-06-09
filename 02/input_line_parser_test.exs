ExUnit.start

Code.require_file "input_line_parser.exs", __DIR__

defmodule InputLineParserTest do
  use ExUnit.Case

  test "parses Game line of input into a Game struct" do
    input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
    expected = %Game{
      id: 1,
      draws: [
        %Draw{red: 4, green: 0, blue: 3},
        %Draw{red: 1, green: 2, blue: 6},
        %Draw{red: 0, green: 2, blue: 0}
      ]
    }

    assert ^expected = InputLineParser.parse_line(input)
  end
end
