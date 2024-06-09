Code.require_file "intcode_program.exs", __DIR__

defmodule IntcodeInputFinder do
  def find_inputs_for(desired_output, program, arg1_range, arg2_range) do
    inputs_to_check = for noun <- arg1_range, verb <- arg2_range, do: {noun, verb}

    inputs_to_check
    |> Enum.map(fn {noun, verb} = inputs ->
      {inputs, IntcodeProgram.run_with_inputs(program, noun, verb)}
    end)
    |> Enum.find(fn {_inputs, finished_program} ->
      IntcodeProgram.output(finished_program) == desired_output
    end)
    |> elem(0)
  end

  def encode_input(noun, verb) do
    100 * noun + verb
  end
end
