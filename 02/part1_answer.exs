Code.require_file "solver.exs", __DIR__

output =
  File.read!(__DIR__ <> "/input")
  |> String.split("\n", trim: true)
  |> Solver.part1(%{red: 12, green: 13, blue: 14})

IO.inspect output
