Code.require_file "solver.exs", __DIR__

output =
  File.read!(__DIR__ <> "/input")
  |> String.split("\n", trim: true)
  |> Solver.part2()

IO.inspect output
