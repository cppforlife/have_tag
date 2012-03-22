require 'rubygems'
require 'bundler/setup'

require 'have_tag'

module ShouldRaiseHelper
  def should_raise(message)
    yield
    fail "Nothing was raised but expected '#{message}'"
  rescue => e
    e.message.should == message
  end
end

class String
  # http://stackoverflow.com/questions/3772864/how-do-i-remove-leading-whitespace-chars-from-ruby-heredoc
  def clean_heredoc
    gsub(/^#{self[/\A\s*/]}/, "").strip
  end
end

RSpec.configure do |config|
  config.include HaveTag
  config.include ShouldRaiseHelper
end
