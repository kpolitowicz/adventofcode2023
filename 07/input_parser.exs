Code.require_file "hand.exs", __DIR__

defmodule InputParser do
  # e.g.
  # 32T3K 765
  # T55J5 684
  # KK677 28
  # KTJJT 220
  # QQQJA 483
  #
  def parse(input) do
    input
    |> Enum.map(fn line ->
      [cards, bid] = String.split(line, " ", trim: true)
      %Hand{cards: cards, bid: String.to_integer(bid)}
    end)
  end
end
