require_relative "routing"

module Solver
  def self.part1(routing)
    routing.resolve.steps
  end
end
