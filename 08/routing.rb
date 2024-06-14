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

  def next_node(current_node, step)
    idx = (navigation[(step % navigation.length)] == "L") ? 0 : 1

    nodes[current_node][idx]
  end
end
