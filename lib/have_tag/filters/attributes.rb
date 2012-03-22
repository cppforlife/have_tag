require "have_tag/helpers"

module HaveTag
  module Filters
    class Attributes
      include AttributesHelpers

      def initialize(attributes)
        @attributes = attributes
      end

      def filter(fragments)
        @matching_fragments = Nokogiri::XML::NodeSet.new(fragments.document)
        @non_matching_fragments = Nokogiri::XML::NodeSet.new(fragments.document)

        fragments.each do |fragment|
          if fragment_attributes_match?(fragment)
            @matching_fragments << fragment
          else
            @non_matching_fragments << fragment
          end
        end

        @matching_fragments
      end

      def failed?
        @matching_fragments.empty?
      end

      def failure
        message  = "Expected fragments with attribute(s) #{attributes_string(@attributes)}.\n"
        message += "Found:"

        @non_matching_fragments.each do |fragment|
          message += "\n  #{fragment.path}\n    #{attributes_string(attributes_hash(fragment))}"
        end
        message
      end

      private

      def fragment_attributes_match?(fragment)
        fragment_attributes = attributes_hash(fragment)

        @attributes.all? do |name, value|
          if value.is_a?(Regexp)
            value.match(fragment_attributes[name.to_s])
          else
            fragment_attributes[name.to_s] == (value ? value.to_s : value)
          end
        end
      end
    end
  end
end