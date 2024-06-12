Code.require_file "card.exs", __DIR__

defmodule Solver do
  def part1(cards) do
    cards
    |> Enum.map(&Card.value/1)
    |> Enum.sum
  end
end
