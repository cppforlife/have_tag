require "spec_helper"

describe "Parser nuances" do
  it "is able to parse html with multiple root nodes" do
    "Text<b>text</b>".should have_tag "b"
  end

  it "is able to parse html style attributes correctly" do
    "<input disabled/><link/>".should have_tag "link"
  end

  %w(html head body).each do |tag|
    it "does not find #{tag} tag when not specified" do
      failure = <<-TEXT.clean_heredoc
        Expected to find "#{tag}" in
        Text<b>text</b>
      TEXT

      should_raise failure do
        "Text<b>text</b>".should have_tag tag
      end
    end
  end

  it "ignores presence of xml declaration" do
    html = <<-HTML
      <?xml version="1.0" encoding="UTF-8"?>
      <html/>
    HTML

    html.should have_tag "html"
  end

  it "ignores presence of xmlns attributes" do
    html = <<-HTML
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en"/>
    HTML

    html.should have_tag "html"
  end

  it "ignores presence of doctype" do
    html = <<-HTML
      <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
      <html/>
    HTML

    html.should have_tag "html"
  end
end