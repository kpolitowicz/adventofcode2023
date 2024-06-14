require "minitest/autorun"

require_relative "routing"

class RoutingTest < Minitest::Test
  def test_initializes_routing_with_navigation
    routing = Routing.new("RL")
    assert_equal ["R", "L"], routing.navigation
  end

  def test_adds_node_to_our_map
    routing = Routing.new("RL")
    routing.add_node("ABC", ["XXX", "YYY"])

    assert_equal ["XXX", "YYY"], routing.nodes["ABC"]
  end

  def test_resolve_shpuld_count_steps_to_follow_navigation
    routing =
      Routing
        .new("LLR")
        .add_node("AAA", ["BBB", "BBB"])
        .add_node("BBB", ["AAA", "ZZZ"])
        .add_node("ZZZ", ["ZZZ", "ZZZ"])
        .resolve

    assert_equal 6, routing.steps
  end
end
