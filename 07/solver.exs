Code.require_file "hand.exs", __DIR__

defmodule Solver do
  def part1(hands) do
    hands
    |> Enum.sort(&Hand.sort_by_first_diff_card/2)
    |> Enum.sort(&Hand.sort_by_type/2)
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {hand, rank}, acc ->
      acc + hand.bid * rank
    end)
  end
end
