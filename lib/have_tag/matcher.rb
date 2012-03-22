require "nokogiri"
require "active_support/core_ext/hash/slice"

require "have_tag/filter_chain"
require "have_tag/filters/selector"
require "have_tag/filters/attributes"
require "have_tag/filters/text"
require "have_tag/filters/count"

module HaveTag
  class Matcher
    def initialize(selector, options={})
      @selector = selector
      @options = options
    end

    def matches?(html_or_object, &block)
      html = html_string(html_or_object).strip

      document = if html.include?('<html')
        Nokogiri::HTML.parse(html)
      else
        Nokogiri::HTML.parse("<html/>").fragment(html)
      end

      @fragments, @failure = filter(document)
      return false if @failure

      with_thread_local(:have_tag_context, @fragments.inner_html) do
        case block.arity
          when -1..0 then yield
          when 1 then yield @fragments.inner_html
          when 2 then yield @fragments.inner_html, attributes_hash(@fragments.first)
        end
      end if block

      true
    end

    def failure_message
      @failure
    end

    def does_not_match?(html_or_object, &block)
      raise "count option is not supported for negative assertions" if count_options.any?
      @options[:exactly] = 0
      matches?(html_or_object, &block)
    end

    def negative_failure_message
      @failure
    end

  private

    def html_string(html_or_object)
      if html_or_object.respond_to?(:html)
        html_or_object.html
      elsif html_or_object.respond_to?(:body)
        html_or_object.body
      else
        html_or_object
      end
    end

    def filter(fragments)
      count_filter = Filters::Count.new(count_options)
      fail_fast = !count_filter.includes_zero?

      chain = FilterChain.new(fail_fast) do |filters|
        filters << Filters::Selector.new(@selector)
        filters << Filters::Attributes.new(@options[:attributes]) if @options[:attributes]
        filters << Filters::Text.new(@options[:text]) if @options[:text]
        filters << count_filter
      end

      chain.filter(fragments)
    end

    def count_options
      @options.slice(:exactly, :at_least, :at_most)
    end

    def attributes_hash(node)
      Hash[node.attribute_nodes.map do |attribute_node|
        [attribute_node.name, attribute_node.value]
      end]
    end

    def with_thread_local(name, value)
      old_value = Thread.current[name]
      Thread.current[name] = value
      yield
    ensure
      Thread.current[name] = old_value
    end
  end
end