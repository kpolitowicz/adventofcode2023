ExUnit.start

Code.require_file "race.exs", __DIR__

defmodule RaceTest do
  use ExUnit.Case

  describe "Race.ways_to_win" do
    test "should calculate number ways to best the given distance" do
      assert 4 = Race.ways_to_win(%Race{time: 7, distance: 9})
      assert 8 = Race.ways_to_win(%Race{time: 15, distance: 40})
      assert 9 = Race.ways_to_win(%Race{time: 30, distance: 200})
    end
  end

  describe "Race.binary_search" do
    test "should find the first time that beats the distance" do
      assert 14 = Race.binary_search(71530, 940200)
    end
  end
end
