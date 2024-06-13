defmodule Hand do
  defstruct [:cards, :bid]

  @type_rank_map %{
    :five_of_a_kind => 7,
    :four_of_a_kind => 6,
    :full_house => 5,
    :three_of_a_kind => 4,
    :two_pair => 3,
    :one_pair => 2,
    :high_card => 1,
  }
  @card_rank_map %{
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "T" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13,
    "A" => 14,
  }

  def sort_by_type(hand1, hand2) do
    @type_rank_map[hand_type(hand1)] <= @type_rank_map[hand_type(hand2)]
  end

  def hand_type(hand) do
    sorted =
      hand.cards
      |> String.split("", trim: true)
      |> Enum.sort()

    case Enum.dedup(sorted) |> length() do
      1 -> :five_of_a_kind
      2 ->
        cond do
          Regex.match?(~r/(.)\1{3}/, List.to_string(sorted)) -> :four_of_a_kind
          true -> :full_house
        end
      3 ->
        cond do
          Regex.match?(~r/(.)\1{2}/, List.to_string(sorted)) -> :three_of_a_kind
          true -> :two_pair
        end
      4 -> :one_pair
      5 -> :high_card
    end
  end

  def sort_by_first_diff_card(hand1, hand2) do
    compare =
      Enum.zip(
        String.split(hand1.cards, "", trim: true),
        String.split(hand2.cards, "", trim: true)
      )
      |> Enum.reject(fn {c1, c2} -> c1 == c2 end)
    compare_cards(compare)
  end

  defp compare_cards([]), do: true
  defp compare_cards([{c1, c2} | _]) do
    @card_rank_map[c1] <= @card_rank_map[c2]
  end
end
