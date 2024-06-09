ExUnit.start

Code.require_file "intcode_program.exs", __DIR__

defmodule IntcodeProgramTest do
  use ExUnit.Case

  test "converts comma-separated string into a tuple" do
    string = "1,2,3\n"
    assert {1,2,3} = IntcodeProgram.read_from(string)
  end

  test "runs the program with custom inputs" do
    assert {2,3,0,6,99} = IntcodeProgram.run_with_inputs({2,9,9,3,99}, 3, 0)
  end

  test "runs the program" do
    assert {2,0,0,0,99} = IntcodeProgram.run({1,0,0,0,99})
    assert {2,3,0,6,99} = IntcodeProgram.run({2,3,0,3,99})
    assert {2,4,4,5,99,9801} = IntcodeProgram.run({2,4,4,5,99,0})
    assert {30,1,1,4,2,5,6,0,99} = IntcodeProgram.run({1,1,1,4,99,5,6,0,99})
  end

  test "gives program output from address 0" do
    assert 1 = IntcodeProgram.output({1,0,0,0,99})
  end
end
