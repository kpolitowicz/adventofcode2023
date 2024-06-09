defmodule Draw do
  defstruct red: 0, green: 0, blue: 0

  def possible?(draw, bag) do
    draw.red <= bag.red and draw.green <= bag.green and draw.blue <= bag.blue
  end
end

defmodule Game do
  defstruct [:id, draws: []]

  def possible?(game, bag) do
    Enum.all?(game.draws, fn draw ->
      Draw.possible?(draw, bag)
    end)
  end
end
