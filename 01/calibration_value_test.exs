ExUnit.start

Code.require_file "calibration_value.exs", __DIR__

defmodule CalibrationValueTest do
  use ExUnit.Case

  test "extracts calibration value from a string" do
    assert 12 = CalibrationValue.extract_from_string("1abc2")
    assert 38 = CalibrationValue.extract_from_string("pqr3stu8vwx")
    assert 15 = CalibrationValue.extract_from_string("a1b2c3d4e5f")
    assert 77 = CalibrationValue.extract_from_string("treb7uchet")
  end
end
