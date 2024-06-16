class Routing
  attr_reader :navigation, :nodes, :steps

  def initialize(navigation)
    @navigation = navigation.chars
    @nodes = {}
  end

  def add_node(name, going_to)
    @nodes[name] = going_to
    self
  end

  def resolve
    current_node = "AAA"
    @steps = (0..).each do |step|
      break step if current_node == "ZZZ"
      current_node = next_node(current_node, step)
    end

    self
  end

  def ghost_resolve
    starting_nodes = nodes.keys.select { |node| node.end_with?("A") }
    steps = starting_nodes.map do |current_node|
      (0..).each do |step|
        break step if current_node.end_with?("Z")
        current_node = next_node(current_node, step)
      end
    end

    # Get least common multiple of all the paths
    @steps = steps.reduce(1) { |acc, n| acc.lcm(n) }

    self
  end

  def next_node(current_node, step)
    idx = (navigation[(step % navigation.length)] == "L") ? 0 : 1

    nodes[current_node][idx]
  end
end
