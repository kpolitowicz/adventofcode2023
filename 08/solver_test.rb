require "minitest/autorun"

require_relative "solver"

class SolverTest < Minitest::Test
  def test_finds_number_of_steps_required_for_part_1
    routing =
      Routing
        .new("RL")
        .add_node("AAA", ["BBB", "CCC"])
        .add_node("BBB", ["DDD", "EEE"])
        .add_node("CCC", ["ZZZ", "GGG"])
        .add_node("DDD", ["DDD", "DDD"])
        .add_node("EEE", ["EEE", "EEE"])
        .add_node("GGG", ["GGG", "GGG"])
        .add_node("ZZZ", ["ZZZ", "ZZZ"])

    assert_equal 2, Solver.part1(routing)
  end

  def test_knows_to_iterate_thru_directions_for_part_1
    routing =
      Routing
        .new("LLR")
        .add_node("AAA", ["BBB", "BBB"])
        .add_node("BBB", ["AAA", "ZZZ"])
        .add_node("ZZZ", ["ZZZ", "ZZZ"])

    assert_equal 6, Solver.part1(routing)
  end
end
