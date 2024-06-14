require "minitest/autorun"

require_relative "input_parser"

class InputParserTest < Minitest::Test
  def test_parses_input_into_routing_instance
    input = [
      "RL",
      "AAA = (BBB, CCC)",
      "BBB = (DDD, EEE)",
      "CCC = (ZZZ, GGG)",
      "DDD = (DDD, DDD)",
      "EEE = (EEE, EEE)",
      "GGG = (GGG, GGG)",
      "ZZZ = (ZZZ, ZZZ)"
    ]
    routing = InputParser.parse(input)
    expected_nodes = {
      "AAA" => %w[BBB CCC],
      "BBB" => %w[DDD EEE],
      "CCC" => %w[ZZZ GGG],
      "DDD" => %w[DDD DDD],
      "EEE" => %w[EEE EEE],
      "GGG" => %w[GGG GGG],
      "ZZZ" => %w[ZZZ ZZZ]
    }

    assert_equal ["R", "L"], routing.navigation
    assert_equal expected_nodes, routing.nodes
  end
end
