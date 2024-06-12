defmodule Card do
  defstruct [:id, :winning, :mine]

  def value(card) do
    winning = MapSet.new(card.winning)
    mine = MapSet.new(card.mine)

    count = MapSet.intersection(winning, mine) |> MapSet.size()
    case count do
      0 -> 0
      _ -> 2 ** (count - 1)
    end
  end
end
