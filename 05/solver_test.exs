ExUnit.start

Code.require_file "solver.exs", __DIR__

defmodule SolverTest do
  use ExUnit.Case

  test "finds the lowest location for part 1" do
    almanac = %Almanac{
      seeds: [79, 14, 55, 13],
      seed_to_soil_map: [
        {50, 98, 2},
        {52, 50, 48},
      ],
      soil_to_fertilizer_map: [
        {0, 15, 37},
        {37, 52, 2},
        {39, 0, 15},
      ],
      fertilizer_to_water_map: [
        {49, 53, 8},
        {0, 11, 42},
        {42, 0, 7},
        {57, 7, 4},
      ],
      water_to_light_map: [
        {88, 18, 7},
        {18, 25, 70},
      ],
      light_to_temperature_map: [
        {45, 77, 23},
        {81, 45, 19},
        {68, 64, 13},
      ],
      temperature_to_humidity_map: [
        {0, 69, 1},
        {1, 0, 69},
      ],
      humidity_to_location_map: [
        {60, 56, 37},
        {56, 93, 4},
      ]
    }

    assert 35 = Solver.part1(almanac)
  end
end
