ExUnit.start

Code.require_file "solver.exs", __DIR__

defmodule SolverTest do
  use ExUnit.Case

  test "finds the sum of hands rank * bid for part 1" do
    hands = [
      %Hand{cards: "32T3K", bid: 765},
      %Hand{cards: "T55J5", bid: 684},
      %Hand{cards: "KK677", bid: 28},
      %Hand{cards: "KTJJT", bid: 220},
      %Hand{cards: "QQQJA", bid: 483},
    ]

    assert 6440 = Solver.part1(hands)
  end
end
