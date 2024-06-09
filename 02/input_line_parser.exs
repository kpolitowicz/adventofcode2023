Code.require_file "game.exs", __DIR__

defmodule InputLineParser do
  # e.g. "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
  def parse_line(input) do
    [game, draws] = String.split(input, ": ")

    %Game{
      id: extract_game_id(game),
      draws: extract_draws(draws)
    }
  end

  defp extract_game_id(game_desc) do
    [_, id_str] = String.split(game_desc, " ")
    String.to_integer(id_str)
  end

  defp extract_draws(draws) do
    String.split(draws, "; ")
    |> Enum.map(&extract_draw_details/1)
  end

  defp extract_draw_details(draw_string) do
    String.split(draw_string, ", ")
    |> Enum.reduce(%Draw{}, fn ball, acc ->
      matches = Regex.named_captures(~r/^(?<count>\d+) (?<color>red|green|blue)$/, ball)
      case matches do
        %{"color" => "red", "count" => cnt} -> %{acc | red: String.to_integer(cnt)}
        %{"color" => "green", "count" => cnt} -> %{acc | green: String.to_integer(cnt)}
        %{"color" => "blue", "count" => cnt} -> %{acc | blue: String.to_integer(cnt)}
      end
    end)
  end
end
