defmodule CalibrationValue do
  @simple_first_number_regex ~r/^[^1-9]*(?<match>\d)/
  @simple_last_number_regex ~r/(?<match>\d)[^1-9]*$/

  @complex_match "[1-9]|one|two|three|four|five|six|seven|eight|nine"
  @complex_first_number_regex ~r/^.*?(?<match>#{@complex_match}).*$/
  @complex_last_number_regex ~r/^.*(?<match>#{@complex_match}).*?$/

  def extract_from_string(str) do
    first = Regex.named_captures(@simple_first_number_regex, str)["match"]
    last = Regex.named_captures(@simple_last_number_regex, str)["match"]

    String.to_integer(first <> last)
  end

  def extract_from_complex_string(str) do
    first = Regex.named_captures(@complex_first_number_regex, str)["match"]
    last = Regex.named_captures(@complex_last_number_regex, str)["match"]

    to_int_string(first) <> to_int_string(last)
    |> String.to_integer()
  end

  # Converts digit specified as word (e.g. "one") into a corresponding
  # regular digit (e.g. "1").
  # Returns converted string digit. If the input `str` does not correspond
  # to any of the "word digits", the original `str` is returned.
  defp to_int_string(str) do
    case str do
      "one" -> "1"
      "two" -> "2"
      "three" -> "3"
      "four" -> "4"
      "five" -> "5"
      "six" -> "6"
      "seven" -> "7"
      "eight" -> "8"
      "nine" -> "9"
      _ -> str
    end
  end
end
