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

  test "should calculate seed's location ranges thru all the maps" do
    almanac = %Almanac{
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

    assert [82..84, 46..55, 60..60] = Almanac.seed_range_locations(almanac, [79..92])
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

  test "should map seed ranges to soil ranges (1 step)" do
    almanac = %Almanac{
      seed_to_soil_map: [
        {50, 98, 2},
        {52, 50, 48},
      ]
    }

    assert [81..94] = Almanac.range_map_with(79..92, almanac.seed_to_soil_map)
  end

  describe "RangeMapper" do
    test "subranges should return the same source range if it is fully contained in one mapping" do
      source_range = 79..92
      mappings = [50..97, 98..99]

      assert [79..92] = RangeMapper.subranges(source_range, mappings)
    end

    test "subranges should return the same source range if it is not contained in any mapping" do
      source_range = 1..45
      mappings = [50..97, 98..99]

      assert [1..45] = RangeMapper.subranges(source_range, mappings)
    end

    test "subranges should handle source range overlapping with just one mapping" do
      source_range = 45..59
      mappings = [50..97, 98..99]

      assert [45..49, 50..59] = RangeMapper.subranges(source_range, mappings)
    end

    test "subranges should handle source range overranging just one mapping" do
      source_range = 45..82
      mappings = [50..78, 98..99]

      assert [45..49, 50..78, 79..82] = RangeMapper.subranges(source_range, mappings)
    end

    test "subranges should return a list of fully fitting ranges if source range extends all mappings" do
      source_range = 1..101 # extends over 2 mappings but starts before the first and ends after the last
      mappings = [98..99, 50..97]

      assert [1..49, 50..97, 98..99, 100..101] = RangeMapper.subranges(source_range, mappings)
    end

    test "subranges should return a list of fully fitting ranges if source range extends over mappings" do
      source_range = 55..99 # extends over 2 mappings but starts within the first range and ends within the last
      mappings = [98..100, 50..97]

      assert [55..97, 98..99] = RangeMapper.subranges(source_range, mappings)
    end

    test "subranges should handle source range beginning and/or ending exctly at one of map ranges" do
      source_range = 50..99 # extends over 2 mappings, start at-- the same point as the first mapping and ends at the last end's
      mappings = [98..99, 50..97]

      assert [50..97, 98..99] = RangeMapper.subranges(source_range, mappings)
    end

    test "subranges should handle source range ending exactly where one of map ranges starts" do
      source_range = 46..56 # extends over 2 mappings, start at the same point as the first mapping and ends at the last end's
      mappings = [56..92, 93..96]

      assert [46..55, 56..56] = RangeMapper.subranges(source_range, mappings)
    end
  end
end
