ExUnit.start

Code.require_file "hand.exs", __DIR__

defmodule HandTest do
  use ExUnit.Case

  describe "Hand.sort_by_type" do
    test "should rank a hand by the type (combo of cards)" do
      assert Hand.sort_by_type(
        %Hand{cards: "23533"},
        %Hand{cards: "AAAAA"}
      )
    end
  end

  describe "Hand.hand_type" do
    test "should classify a hand by the type (combo of cards)" do
      assert :five_of_a_kind = Hand.hand_type(%Hand{cards: "AAAAA"})
      assert :four_of_a_kind = Hand.hand_type(%Hand{cards: "AA8AA"})
      assert :full_house = Hand.hand_type(%Hand{cards: "23233"})
      assert :three_of_a_kind = Hand.hand_type(%Hand{cards: "23533"})
      assert :two_pair = Hand.hand_type(%Hand{cards: "23523"})
      assert :one_pair = Hand.hand_type(%Hand{cards: "2352K"})
      assert :high_card = Hand.hand_type(%Hand{cards: "235AK"})
    end
  end

  describe "Hand.sort_by_first_diff_card" do
    test "should rank a hand with higher first diff card higher" do
      assert Hand.sort_by_first_diff_card(
        %Hand{cards: "T55J5", bid: 684},
        %Hand{cards: "QQQJA", bid: 483}
      )
      assert Hand.sort_by_first_diff_card(
        %Hand{cards: "KTJJT", bid: 220},
        %Hand{cards: "KK677", bid: 28}
      )
    end
  end
end
