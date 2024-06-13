ExUnit.start

Code.require_file "solver.exs", __DIR__

defmodule SolverTest do
  use ExUnit.Case

  test "finds the product of number of ways to beat each race for part 1" do
    races = [
      %Race{time: 7, distance: 9},
      %Race{time: 15, distance: 40},
      %Race{time: 30, distance: 200},
    ]

    assert 288 = Solver.part1(races)
  end

  test "finds the number of ways to beat THE ONLY race for part 2" do
    races = [
      %Race{time: 71530, distance: 940200},
    ]

    assert 71503 = Solver.part2(races)
  end
end
