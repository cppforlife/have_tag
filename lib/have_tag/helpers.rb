module HaveTag
  module AttributesHelpers
    def attributes_hash(node)
      Hash[node.attribute_nodes.map do |attribute_node|
        [attribute_node.name, attribute_node.value]
      end]
    end

    def attributes_string(attributes)
      if attributes.empty?
        "(no attributes)"
      else
        sorted_attributes = attributes.sort_by { |name, value| name.to_s }
        sorted_attributes.map { |(name, value)| "#{name}=\"#{value}\"" }.join(", ")
      end
    end
  end
end