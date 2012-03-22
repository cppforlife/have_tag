module HaveTag
  module Filters
    class Selector
      def initialize(selector)
        @selector = selector.to_s
      end

      def filter(fragments)
        @fragments = fragments
        @matching_fragments = fragments.css(@selector)
      end

      def failed?
        @matching_fragments.empty?
      end

      def failure
        "Expected to find \"#{@selector}\" in\n#{fragments_pretty_output}"
      end

      private

      def fragments_pretty_output
        save_options = Nokogiri::XML::Node::SaveOptions.new
        save_options.format
        save_options.as_xml
        save_options.no_declaration

        output = @fragments.to_xml(:save_with => save_options, :index => 2).strip
        output.empty? ? "  (cannot be serialized)" : output
      end
    end
  end
end