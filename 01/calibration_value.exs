defmodule CalibrationValue do
  def extract_from_string(str) do
    first = Regex.named_captures(~r/^[^0-9]*(?<match>\d)/, str)["match"]
    last = Regex.named_captures(~r/(?<match>\d)[^0-9]*$/, str)["match"]

    Integer.parse(first <> last) |> elem(0)
  end
end
