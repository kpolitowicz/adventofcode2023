require_relative "routing"

module InputParser
  def self.parse(input)
    navigation_line = input.shift

    routing = Routing.new(navigation_line)

    input.each do |node_line|
      parse_node(node_line, routing)
    end

    routing
  end

  def self.parse_node(node_line, routing)
    node, going_to = node_line.split(" = ")
    left, right = going_to.scan(/[A-Z]+/)

    routing.add_node(node, [left, right])
  end
end
