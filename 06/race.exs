defmodule Race do
  defstruct time: 0, distance: 0

  def ways_to_win(race) do
    first_beating = binary_search(race.time, race.distance)
    # {x, y} =
    #   Enum.zip(0..race.time, race.time..0)
    #   |> Enum.find(fn {x, y} -> x * y > race.distance end)
    hold_time = first_beating
    race_time = race.time - first_beating

    race_time - hold_time + 1
  end

  # We're starting with 0..time/2 range.
  # We're looking for THE FIRST time that beats the distance
  # (that time - 1 will NOT beat the distance)
  def binary_search(time, distance_to_beat) do
    binary_search(Range.new(0, div(time, 2)), time, distance_to_beat)
  end

  defp binary_search(current_range, time, distance_to_beat, deep \\ 0) do
    s..e//_ = current_range
    mid = s + div(e - s, 2)


    mid_dist = eval_time(mid, time)
    mid_minus_one_dist = eval_time(mid - 1, time)

    cond do
      mid_dist > distance_to_beat and mid_minus_one_dist <= distance_to_beat -> mid
      mid_dist > distance_to_beat -> binary_search(Range.new(s, mid), time, distance_to_beat, deep + 1)
      true -> binary_search(Range.new(mid, e), time, distance_to_beat, deep + 1)
    end
  end

  defp eval_time(hold_time, race_time) do
    hold_time * (race_time - hold_time)
  end
end
