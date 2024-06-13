Code.require_file "input_parser.exs", __DIR__
Code.require_file "solver.exs", __DIR__

output =
  File.read!(__DIR__ <> "/input")
  |> String.split("\n", trim: true)
  |> InputParser.parse_ignoring_kerning()
  |> Solver.part2()

IO.inspect output
