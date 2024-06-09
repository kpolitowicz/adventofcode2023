Code.require_file "intcode_input_finder.exs", __DIR__

{:ok, program_str} = File.read(__DIR__ <> "/input.txt")
program = IntcodeProgram.read_from(program_str)

desired_output = 19690720
inputs_range = 0..99
{matching_noun, matching_verb} =
  IntcodeInputFinder.find_inputs_for(desired_output, program, inputs_range, inputs_range)

IO.puts IntcodeInputFinder.encode_input(matching_noun, matching_verb)
