Code.require_file "input_parser.exs", __DIR__
Code.require_file "solver.exs", __DIR__

output =
  File.read!(__DIR__ <> "/input")
  |> String.split("\n", trim: true)
  |> InputParser.parse()
  |> Solver.part1()

IO.inspect output
