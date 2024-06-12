defmodule Almanac do
  defstruct seeds: [],
    seed_to_soil_map: [],
    soil_to_fertilizer_map: [],
    fertilizer_to_water_map: [],
    water_to_light_map: [],
    light_to_temperature_map: [],
    temperature_to_humidity_map: [],
    humidity_to_location_map: []

    def seed_location(almanac, seed) do
      seed
      |> Almanac.map_with(almanac.seed_to_soil_map)
      |> Almanac.map_with(almanac.soil_to_fertilizer_map)
      |> Almanac.map_with(almanac.fertilizer_to_water_map)
      |> Almanac.map_with(almanac.water_to_light_map)
      |> Almanac.map_with(almanac.light_to_temperature_map)
      |> Almanac.map_with(almanac.temperature_to_humidity_map)
      |> Almanac.map_with(almanac.humidity_to_location_map)
    end

    def map_with(source, mapping) do
      conversion =
        mapping
        |> Enum.filter(fn range ->
          {_dest, src, len} = range
          source >= src && source <= (src + len - 1)
        end)

      case conversion do
        [] -> source
        [{dest, src, _len}] -> source - src + dest
      end
    end
end
