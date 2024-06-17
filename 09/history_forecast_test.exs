ExUnit.start

Code.require_file "history_forecast.exs", __DIR__

defmodule HistoryForecastTest do
  use ExUnit.Case

  describe "HistoryForecast.next_value" do
    test "should predict the next value in the sequence" do
      assert 18 = HistoryForecast.next_value([0, 3, 6, 9, 12, 15])
      assert 28 = HistoryForecast.next_value([1, 3, 6, 10, 15, 21])
      assert 68 = HistoryForecast.next_value([10, 13, 16, 21, 30, 45])
    end
  end

  describe "HistoryForecast.past_value" do
    test "should extrapolate the value before first in the sequence" do
      assert -3 = HistoryForecast.past_value([0, 3, 6, 9, 12, 15])
      assert 0 = HistoryForecast.past_value([1, 3, 6, 10, 15, 21])
      assert 5 = HistoryForecast.past_value([10, 13, 16, 21, 30, 45])
    end
  end
end
