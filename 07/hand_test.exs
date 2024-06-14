ExUnit.start

Code.require_file "hand.exs", __DIR__

defmodule HandTest do
  use ExUnit.Case

  describe "Hand.sort_by_type" do
    test "should rank a hand by the type (combo of cards)" do
      assert Hand.sort_by_type(
        %Hand{cards: "23533"},
        %Hand{cards: "AAAAA"},
        &Hand.hand_type/1
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

  describe "Hand.hand_type_with_jokers" do
    test "should classify a hand by the type with jokers making the strongest possible hand" do
      assert :five_of_a_kind = Hand.hand_type_with_jokers(%Hand{cards: "AAJJA"})
      assert :four_of_a_kind = Hand.hand_type_with_jokers(%Hand{cards: "AJ8AA"})
      assert :full_house = Hand.hand_type_with_jokers(%Hand{cards: "2323J"})
      assert :three_of_a_kind = Hand.hand_type_with_jokers(%Hand{cards: "2J533"})
      assert :one_pair = Hand.hand_type_with_jokers(%Hand{cards: "235JK"})
    end
  end

  describe "Hand.sort_by_first_diff_card" do
    test "should rank a hand with higher first diff card higher" do
      assert Hand.sort_by_first_diff_card(
        %Hand{cards: "T55J5", bid: 684},
        %Hand{cards: "QQQJA", bid: 483},
        Hand.card_rank_map()
      )
      assert Hand.sort_by_first_diff_card(
        %Hand{cards: "KTJJT", bid: 220},
        %Hand{cards: "KK677", bid: 28},
        Hand.card_rank_map()
      )
    end

    test "should rank a hand with higher first diff card higher with J being the weakest" do
      assert Hand.sort_by_first_diff_card(
        %Hand{cards: "JKKK2", bid: 684},
        %Hand{cards: "33332", bid: 483},
        Hand.card_rank_map_with_jokers()
      )
    end
  end
end
