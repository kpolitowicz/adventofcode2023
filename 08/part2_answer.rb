require_relative "input_parser"
require_relative "solver"

input_file = "#{__dir__}/input"

input_lines = File.read(input_file).split("\n").reject(&:empty?)
output = Solver.part2(InputParser.parse(input_lines))

puts output
