Code.require_file "almanac.exs", __DIR__

defmodule InputParser do
  # e.g.
  # seeds: 79 14 55 13
  #
  # seed-to-soil map:
  # 50 98 2
  # 52 50 48
  #
  # soil-to-fertilizer map:
  # 0 15 37
  # 37 52 2
  # 39 0 15
  #
  # fertilizer-to-water map:
  # 49 53 8
  # 0 11 42
  # 42 0 7
  # 57 7 4
  #
  # water-to-light map:
  # 88 18 7
  # 18 25 70
  #
  # light-to-temperature map:
  # 45 77 23
  # 81 45 19
  # 68 64 13
  #
  # temperature-to-humidity map:
  # 0 69 1
  # 1 0 69
  #
  # humidity-to-location map:
  # 60 56 37
  # 56 93 4
  #
  def parse(input) do
    [seeds | maps] = input
    parsed_maps = parse_maps(maps)

    %Almanac{
      seeds: parse_seeds(seeds),
      seed_to_soil_map: parsed_maps["seed-to-soil map:"] |> Enum.reverse(),
      soil_to_fertilizer_map: parsed_maps["soil-to-fertilizer map:"] |> Enum.reverse(),
      fertilizer_to_water_map: parsed_maps["fertilizer-to-water map:"] |> Enum.reverse(),
      water_to_light_map: parsed_maps["water-to-light map:"] |> Enum.reverse(),
      light_to_temperature_map: parsed_maps["light-to-temperature map:"] |> Enum.reverse(),
      temperature_to_humidity_map: parsed_maps["temperature-to-humidity map:"] |> Enum.reverse(),
      humidity_to_location_map: parsed_maps["humidity-to-location map:"] |> Enum.reverse(),
    }
  end

  # e.g.
  # seeds: 79 14 55 13
  defp parse_seeds(seeds_str) do
    ["seeds", nums] = String.split(seeds_str, ": ")
    parse_nums(nums)
  end

  defp parse_maps(maps), do: parse_maps(maps, %{}, nil)
  defp parse_maps([], parsed_map, _current_map), do: parsed_map
  defp parse_maps(maps, parsed_map, current_map) do
    [line | rest] = maps
    cond do
      String.ends_with?(line, ":") ->
        parsed_map = Map.put_new(parsed_map, line, [])
        parse_maps(rest, parsed_map, line)
      true ->
        nums = parse_nums(line) |> List.to_tuple()
        parsed_map = Map.update!(parsed_map, current_map, fn list -> [nums | list] end)
        parse_maps(rest, parsed_map, current_map)
    end
  end

  defp parse_nums(nums), do: String.split(nums, " ") |> Enum.map(&String.to_integer/1)
end
