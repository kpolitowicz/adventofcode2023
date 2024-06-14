Code.require_file "hand.exs", __DIR__

defmodule Solver do
  def part1(hands) do
    hands
    |> Enum.sort(fn h1, h2 ->
      Hand.sort_by_first_diff_card(h1, h2, Hand.card_rank_map())
    end)
    |> Enum.sort(fn h1, h2 ->
      Hand.sort_by_type(h1, h2, &Hand.hand_type/1)
    end)
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {hand, rank}, acc ->
      acc + hand.bid * rank
    end)
  end

  def part2(hands) do
    hands
    |> Enum.sort(fn h1, h2 ->
      Hand.sort_by_first_diff_card(h1, h2, Hand.card_rank_map_with_jokers())
    end)
    |> Enum.sort(fn h1, h2 ->
      Hand.sort_by_type(h1, h2, &Hand.hand_type_with_jokers/1)
    end)
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {hand, rank}, acc ->
      acc + hand.bid * rank
    end)
  end
end
