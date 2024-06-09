Code.require_file "input_line_parser.exs", __DIR__

defmodule Solver do
  def part1(input, bag) do
    games = Enum.map(input, &InputLineParser.parse_line/1)

    games
    |> Enum.filter(fn game -> Game.possible?(game, bag) end)
    |> Enum.reduce(0, fn game, acc -> acc + game.id end)
  end
end
