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

  def seed_range_locations(almanac, seed_ranges) do
    seed_ranges
    |> Enum.flat_map(fn range -> Almanac.range_map_with(range, almanac.seed_to_soil_map) end)
    |> Enum.flat_map(fn range -> Almanac.range_map_with(range, almanac.soil_to_fertilizer_map) end)
    |> Enum.flat_map(fn range -> Almanac.range_map_with(range, almanac.fertilizer_to_water_map) end)
    |> Enum.flat_map(fn range -> Almanac.range_map_with(range, almanac.water_to_light_map) end)
    |> Enum.flat_map(fn range -> Almanac.range_map_with(range, almanac.light_to_temperature_map) end)
    |> Enum.flat_map(fn range -> Almanac.range_map_with(range, almanac.temperature_to_humidity_map) end)
    |> Enum.flat_map(fn range -> Almanac.range_map_with(range, almanac.humidity_to_location_map) end)
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

  def range_map_with(source_range, mapping) do
    mapping_ranges =
      mapping
      |> Enum.reduce(%{}, fn {dest, src, len}, acc ->
        Map.put_new(acc, Range.new(src, src + len - 1), dest - src)
      end)
    subranges = RangeMapper.subranges(source_range, Map.keys(mapping_ranges))

    subranges
    |> Enum.map(fn subrange -> chunk_range_map_with(subrange, mapping_ranges) end)
  end

  defp chunk_range_map_with(range, mapping_ranges) do
    s..e//_ = range
    overlapping_range =
      Map.keys(mapping_ranges)
      |> Enum.find(fn rng -> not Range.disjoint?(range, rng) end)
    diff = case overlapping_range do
      nil -> 0
      _ -> mapping_ranges[overlapping_range]
    end

    Range.new(s + diff, e + diff)
  end
end

defmodule RangeMapper do
  def subranges(source_range, mapping_ranges) do
    overlapping =
      mapping_ranges
      |> Enum.reject(fn rng ->
        Range.disjoint?(source_range, rng)
      end)
      |> Enum.sort_by(fn s.._//_ -> s end)

    calculate_subranges(source_range, overlapping)
  end

  defp calculate_subranges(source_range, []), do: [source_range]
  defp calculate_subranges(source_range, overlapping) do
    src_s..src_e//_ = source_range
    [first_rng_s.._//_ | _] = overlapping
    points = [src_s, first_rng_s - 1]

    points =
      overlapping
      |> Enum.reduce(points, fn rng_s..rng_e//_, acc ->
        acc ++ [rng_s, rng_e]
      end)

    _..last_rng_e//_ = Enum.at(overlapping, -1)
    points = points ++ [last_rng_e + 1, src_e]

    points = Enum.reject(points, fn p -> p < src_s or p > src_e end)

    # This is ugly, but it prevents valid one-item ranges from disappearing
    # after uniq. We only want to dedupe if there are 2 pairs of the same
    # points. See which tests are failing without this block (or if block
    # is replaced with Enum.uniq for all cases).
    deduped = Enum.uniq(points)
    points = if length(deduped) |> Integer.mod(2) == 1 do
      points
    else
      deduped
    end

    points
    |> Enum.chunk_every(2)
    |> Enum.map(fn [s, e] -> Range.new(s, e) end)
  end
end
