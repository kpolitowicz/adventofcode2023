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
end
