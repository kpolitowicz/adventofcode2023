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
  @card_rank_map_with_jokers %{
    "J" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "T" => 10,
    "Q" => 12,
    "K" => 13,
    "A" => 14,
  }

  def card_rank_map(), do: @card_rank_map
  def card_rank_map_with_jokers(), do: @card_rank_map_with_jokers

  def sort_by_type(hand1, hand2, type_finder) do
    @type_rank_map[type_finder.(hand1)] <= @type_rank_map[type_finder.(hand2)]
  end

  def hand_type(hand) do
    sorted =
      hand.cards
      |> String.split("", trim: true)
      |> Enum.sort()

    determine_type(sorted)
  end

  def hand_type_with_jokers(hand) do
    hand.cards
    |> String.split("", trim: true)
    |> Enum.sort(fn c1, c2 -> @card_rank_map_with_jokers[c1] >= @card_rank_map_with_jokers[c2] end)
    |> Enum.split_while(fn c -> c != "J" end)
    |> determine_type_with_jokers()
  end

  defp determine_type(sorted) do
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

  defp determine_type_with_jokers({other_cards, jokers}) do
    type_without_jokers = pad_to_five(other_cards) |> determine_type()
    case {type_without_jokers, length(jokers)} do
      {any_type, 0} -> any_type
      {:four_of_a_kind, 1} -> :five_of_a_kind
      {:three_of_a_kind, 1} -> :four_of_a_kind
      {:two_pair, 1} -> :full_house
      {:one_pair, 1} -> :three_of_a_kind
      {:high_card, 1} -> :one_pair
      {:three_of_a_kind, 2} -> :five_of_a_kind
      {:one_pair, 2} -> :four_of_a_kind
      {:high_card, 2} -> :three_of_a_kind
      {:one_pair, 3} -> :five_of_a_kind
      {:high_card, 3} -> :four_of_a_kind
      {:high_card, 4} -> :five_of_a_kind
      {_any_type, 5} -> :five_of_a_kind
    end
  end

  defp pad_to_five(cards) do
    symbols = ["!", "@", "#", "$"]
    pad = 5 - length(cards)
    cards ++ Enum.slice(symbols, 0, pad)
  end

  def sort_by_first_diff_card(hand1, hand2, ranker) do
    compare =
      Enum.zip(
        String.split(hand1.cards, "", trim: true),
        String.split(hand2.cards, "", trim: true)
      )
      |> Enum.reject(fn {c1, c2} -> c1 == c2 end)
    compare_cards(compare, ranker)
  end

  defp compare_cards([], _ranks), do: true
  defp compare_cards([{c1, c2} | _], ranks) do
    ranks[c1] <= ranks[c2]
  end
end
