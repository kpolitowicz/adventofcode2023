ExUnit.start

Code.require_file "solver.exs", __DIR__

defmodule SolverTest do
  use ExUnit.Case

  test "finds the sum of forecasts for part 1" do
    history = [
      [0, 3, 6, 9, 12, 15],
      [1, 3, 6, 10, 15, 21],
      [10, 13, 16, 21, 30, 45]
    ]

    assert 114 = Solver.part1(history)
  end
end
