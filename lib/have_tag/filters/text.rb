module HaveTag
  module Filters
    class Text
      def initialize(text)
        @text = text
      end

      def filter(fragments)
        @matching_fragments = Nokogiri::XML::NodeSet.new(fragments.document)
        @non_matching_fragments = Nokogiri::XML::NodeSet.new(fragments.document)

        fragments.each do |fragment|
          if fragment_text_match?(fragment)
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
        message  = "Expected fragments with \"#{@text}\" text.\n"
        message += "Found:"

        @non_matching_fragments.each do |fragment|
          message += "\n  #{fragment.path}\n    \"#{fragment_text(fragment)}\""
        end
        message
      end

      private

      def fragment_text_match?(fragment)
        if @text.is_a?(Regexp)
          @text.match(fragment_text(fragment))
        else
          fragment_text(fragment) == @text
        end
      end

      def fragment_text(fragment)
        fragment.inner_text.strip
      end
    end
  end
end