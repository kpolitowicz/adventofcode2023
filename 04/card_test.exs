ExUnit.start

Code.require_file "card.exs", __DIR__

defmodule CardTest do
  use ExUnit.Case

  test "should calculate the point value of a card" do
    eight_points =
      %Card{id: 1, winning: [41, 48, 83, 86, 17], mine: [83, 86,  6, 31, 17,  9, 48, 53]}
    zero_points =
      %Card{id: 6, winning: [31, 18, 13, 56, 72], mine: [74, 77, 10, 23, 35, 67, 36, 11]}

    assert 8 = Card.value(eight_points)
    assert 0 = Card.value(zero_points)
  end

  test "should count how many winning numbers we have" do
    four_wins =
      %Card{id: 1, winning: [41, 48, 83, 86, 17], mine: [83, 86,  6, 31, 17,  9, 48, 53]}
    zero_wins =
      %Card{id: 6, winning: [31, 18, 13, 56, 72], mine: [74, 77, 10, 23, 35, 67, 36, 11]}

    assert 4 = Card.win_count(four_wins)
    assert 0 = Card.win_count(zero_wins)
  end

  test "pool should init with 1 copy (original) of each card" do
    cards = [
      %Card{id: 1, winning: [41, 48, 83, 86, 17], mine: [83, 86,  6, 31, 17,  9, 48, 53]},
      %Card{id: 2, winning: [13, 32, 20, 16, 61], mine: [61, 30, 68, 82, 17, 32, 24, 19]},
      %Card{id: 3, winning: [ 1, 21, 53, 59, 44], mine: [69, 82, 63, 72, 16, 21, 14,  1]},
      %Card{id: 4, winning: [41, 92, 73, 84, 69], mine: [59, 84, 76, 51, 58,  5, 54, 83]},
      %Card{id: 5, winning: [87, 83, 26, 28, 32], mine: [88, 30, 70, 12, 93, 22, 82, 36]},
      %Card{id: 6, winning: [31, 18, 13, 56, 72], mine: [74, 77, 10, 23, 35, 67, 36, 11]},
    ]
    expected = %{
      1 => 1,
      2 => 1,
      3 => 1,
      4 => 1,
      5 => 1,
      6 => 1,
    }

    assert ^expected = Pool.new(cards)
  end

  test "pool should resolve a card and add copies of subsequent cards on a win" do
    starting_pool = %{
      1 => 1,
      2 => 2,
      3 => 2,
      4 => 2,
      5 => 2,
      6 => 1,
    }
    next_card = %Card{id: 2, winning: [13, 32, 20, 16, 61], mine: [61, 30, 68, 82, 17, 32, 24, 19]}
    expected = %{
      1 => 1,
      2 => 2,
      3 => 4,
      4 => 4,
      5 => 2,
      6 => 1,
    }

    assert ^expected = Pool.resolve(starting_pool, next_card)
  end

  test "pool should handle 0 win cards" do
    starting_pool = %{
      1 => 1,
      2 => 2,
      3 => 2,
      4 => 2,
      5 => 2,
      6 => 1,
    }
    next_card = %Card{id: 6, winning: [31, 18, 13, 56, 72], mine: [74, 77, 10, 23, 35, 67, 36, 11]}

    assert ^starting_pool = Pool.resolve(starting_pool, next_card)
  end
end
