defmodule Card do
  defstruct [:id, :winning, :mine]

  def value(card) do
    count = win_count(card)
    case count do
      0 -> 0
      _ -> 2 ** (count - 1)
    end
  end

  def win_count(card) do
    winning = MapSet.new(card.winning)
    mine = MapSet.new(card.mine)

    MapSet.intersection(winning, mine) |> MapSet.size()
  end
end

defmodule Pool do
  def new(cards) do
    for card <- cards, into: %{} do
      {card.id, 1}
    end
  end

  def resolve(pool, card) do
    wins = Card.win_count(card)

    if wins > 0 do
      (card.id+1)..(card.id+wins)
      |> Enum.reduce(pool, fn id, acc ->
        Map.update!(acc, id, fn x -> x + pool[card.id] end)
      end)
    else
      pool
    end
  end
end
