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

  test "extracts calibration value from a string with numbers spelled out" do
    assert 29 = CalibrationValue.extract_from_complex_string("two1nine")
    assert 83 = CalibrationValue.extract_from_complex_string("eightwothree")
    assert 13 = CalibrationValue.extract_from_complex_string("abcone2threexyz")
    assert 24 = CalibrationValue.extract_from_complex_string("xtwone3four")
    assert 42 = CalibrationValue.extract_from_complex_string("4nineeightseven2")
    assert 14 = CalibrationValue.extract_from_complex_string("zoneight234")
    assert 76 = CalibrationValue.extract_from_complex_string("7pqrstsixteen")
    assert 99 = CalibrationValue.extract_from_complex_string("9hcj")
    assert 21 = CalibrationValue.extract_from_complex_string("twone")
    assert 41 = CalibrationValue.extract_from_complex_string("4seven1smptmjbfsztwo6eighttwotwonevcv")
  end
end
