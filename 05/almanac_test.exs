ExUnit.start

Code.require_file "almanac.exs", __DIR__

defmodule AlmanacTest do
  use ExUnit.Case

  test "should calculate seed's location thru all the maps" do
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

    assert 82 = Almanac.seed_location(almanac, 79)
    assert 43 = Almanac.seed_location(almanac, 14)
    assert 86 = Almanac.seed_location(almanac, 55)
    assert 35 = Almanac.seed_location(almanac, 13)
  end

  test "should calculate seed's soil (1 step) thru seed_to_soil_map" do
    almanac = %Almanac{
      seeds: [79, 14, 55, 13],
      seed_to_soil_map: [
        {50, 98, 2},
        {52, 50, 48},
      ]
    }

    assert 81 = Almanac.map_with(79, almanac.seed_to_soil_map)
    assert 14 = Almanac.map_with(14, almanac.seed_to_soil_map)
    assert 57 = Almanac.map_with(55, almanac.seed_to_soil_map)
    assert 13 = Almanac.map_with(13, almanac.seed_to_soil_map)
  end
end
