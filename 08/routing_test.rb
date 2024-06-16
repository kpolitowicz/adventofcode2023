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

  def test_resolve_should_count_steps_to_follow_navigation
    routing =
      Routing
        .new("LLR")
        .add_node("AAA", ["BBB", "BBB"])
        .add_node("BBB", ["AAA", "ZZZ"])
        .add_node("ZZZ", ["ZZZ", "ZZZ"])
        .resolve

    assert_equal 6, routing.steps
  end

  def test_ghost_resolve_should_count_steps_to_follow_ghostly_navigation
    routing =
      Routing
        .new("LR")
        .add_node("11A", ["11B", "XXX"])
        .add_node("11B", ["XXX", "11Z"])
        .add_node("11Z", ["11B", "XXX"])
        .add_node("22A", ["22B", "XXX"])
        .add_node("22B", ["22C", "22C"])
        .add_node("22C", ["22Z", "22Z"])
        .add_node("22Z", ["22B", "22B"])
        .add_node("XXX", ["XXX", "XXX"])
        .ghost_resolve

    assert_equal 6, routing.steps
  end
end
