defmodule CalibrationValue do
  def extract_from_string(str) do
    first = Regex.named_captures(~r/^[^0-9]*(?<match>\d)/, str)["match"]
    last = Regex.named_captures(~r/(?<match>\d)[^0-9]*$/, str)["match"]

    Integer.parse(first <> last) |> elem(0)
  end

  def extract_from_complex_string(str) do
    matching = "[1-9]|one|two|three|four|five|six|seven|eight|nine"

    first = Regex.named_captures(~r/^.*?(?<match>#{matching}).*$/, str)["match"]
    last = Regex.named_captures(~r/^.*(?<match>#{matching}).*?$/, str)["match"]

    res =
    to_int(first) <> to_int(last)
    |> Integer.parse()
    |> elem(0)

    # IO.inspect({str, res, first, last})

    res
  end

  defp to_int(str) do
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
