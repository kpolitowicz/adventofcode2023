Code.require_file "card.exs", __DIR__

defmodule Solver do
  def part1(cards) do
    cards
    |> Enum.map(&Card.value/1)
    |> Enum.sum
  end

  def part2(cards) do
    cards
    |> Enum.reduce(Pool.new(cards), fn card, acc ->
      Pool.resolve(acc, card)
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
