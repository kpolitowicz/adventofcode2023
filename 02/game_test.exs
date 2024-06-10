ExUnit.start

Code.require_file "game.exs", __DIR__

defmodule GameTest do
  use ExUnit.Case

  test "checks if draw is possible from a given bag" do
    bag = %{red: 12, green: 13, blue: 14}

    assert Draw.possible?(%Draw{red: 4, blue: 3}, bag)
    refute Draw.possible?(%Draw{red: 20, blue: 6}, bag)
  end

  test "checks if game is possible with a given bag" do
    bag = %{red: 12, green: 13, blue: 14}
    possible_game = %Game{
      id: 1,
      draws: [
        # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        %Draw{red: 4, blue: 3},
        %Draw{red: 1, green: 2, blue: 6},
        %Draw{green: 2}
      ]
    }
    impossible_game = %Game{
      id: 3,
      draws: [
        # Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        %Draw{red: 20, green: 8, blue: 6},
        %Draw{red: 4, green: 13, blue: 5},
        %Draw{red: 1, green: 5}
      ]
    }

    assert Game.possible?(possible_game, bag)
    refute Game.possible?(impossible_game, bag)
  end

  test "knows the minimum bag to play given game" do
    game = %Game{
      id: 1,
      draws: [
        # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        %Draw{red: 4, blue: 3},
        %Draw{red: 1, green: 2, blue: 6},
        %Draw{green: 2}
      ]
    }

    assert %{red: 4, green: 2, blue: 6} = Game.min_set(game)
  end
end
