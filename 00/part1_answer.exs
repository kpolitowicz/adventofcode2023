Code.require_file "intcode_program.exs", __DIR__

{:ok, program_str} = File.read(__DIR__ <> "/input.txt")

noun = 12
verb = 2
program =
  IntcodeProgram.read_from(program_str)
  |> IntcodeProgram.run_with_inputs(noun, verb)

IO.puts IntcodeProgram.output(program)
