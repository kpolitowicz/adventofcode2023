Code.require_file "calibration_value.exs", __DIR__

output =
  File.read!(__DIR__ <> "/input")
  |> String.split("\n", trim: true)
  |> Enum.map(&CalibrationValue.extract_from_complex_string/1)
  |> Enum.reduce(fn x, acc -> x + acc end)


# 53846 - wrong
# IO.puts("[")
# Enum.map(output, fn x -> IO.puts("#{x},") end)
# IO.puts("]")

IO.puts output
