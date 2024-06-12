Code.require_file "card.exs", __DIR__

defmodule InputParser do
  # e.g.
  #
  # Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  # Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
  # Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
  # Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
  # Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
  # Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
  #
  def parse(input) do
    input
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [card_id, numbers] = String.split(line, ": ")
    [winning, mine] = String.split(numbers, " | ")

    %Card{
      id: parse_card_id(card_id),
      winning: parse_numbers(winning),
      mine: parse_numbers(mine),
    }
  end

  defp parse_card_id(card_id_str) do
    ["Card", id_str] = String.split(card_id_str, " ", trim: true)
    String.to_integer(id_str)
  end

  def parse_numbers(numbers) do
    String.split(numbers, " ", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end
end
