defmodule Race do
  defstruct time: 0, distance: 0

  def ways_to_win(race) do
    {x, y} =
      Enum.zip(0..race.time, race.time..0)
      |> Enum.find(fn {x, y} -> x * y > race.distance end)

    y - x + 1
  end
end
