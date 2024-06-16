require_relative "routing"

module Solver
  def self.part1(routing)
    routing.resolve.steps
  end

  def self.part2(routing)
    routing.ghost_resolve.steps
  end
end
