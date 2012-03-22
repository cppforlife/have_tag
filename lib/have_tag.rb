require "active_support/core_ext/hash/slice"
require "have_tag/version"
require "have_tag/matcher"

module HaveTag
  def have_tag(selector, html_attributes={}, options={})
    if options.empty? && html_attributes.slice(:exactly, :at_least, :at_most, :text).any?
      options = html_attributes
    else
      options[:attributes] = html_attributes
    end

    Matcher.new(selector, options)
  end

  def with_tag(*args, &block)
    Thread.current[:have_tag_context].tap do |context|
      raise "with_tag can only be used inside have_tag block" unless context
      context.should have_tag(*args), &block
    end
  end

  def without_tag(*args, &block)
    Thread.current[:have_tag_context].tap do |context|
      raise "without_tag can only be used inside have_tag block" unless context
      context.should_not have_tag(*args), &block
    end
  end
end
