require "have_tag/helpers"

module HaveTag
  module Filters
    class Count
      include AttributesHelpers

      def initialize(options)
        @options = options
      end

      def includes_zero?
        case count_type
          when :exactly then count_value == 0
          when :at_least then count_value == 0
          when :at_most then true
        end
      end

      def filter(fragments)
        @fragments = fragments

        if failed?
          Nokogiri::XML::NodeSet.new(@fragments.document)
        else
          @fragments
        end
      end

      def failed?
        !@fragments.length.send(count_operand, count_value)
      end

      def failure
        message  = "Expected #{count_type_human} #{count_value} fragment(s).\n"
        message += "Found #{@fragments.length} fragment(s):"

        @fragments.each do |fragment|
          attrs = attributes_string(attributes_hash(fragment))
          html = fragment.inner_html.strip
          message += "\n  #{fragment.path}\n    #{attrs}\n    \"#{html}\""
        end
        message
      end

      private

      def count_type
        @options.keys.first || :at_least
      end

      def count_value
        @options.values.first || 1
      end

      def count_type_human
        count_type.to_s.gsub("_", " ")
      end

      def count_operand
        case count_type
          when :exactly then :==
          when :at_least then :>=
          when :at_most then :<=
        end
      end
    end
  end
end