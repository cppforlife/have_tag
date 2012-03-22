require "spec_helper"

describe "Integration" do
  describe "text and count options" do
    it "passes when there are specified number of tags with specific text" do
      html = <<-HTML.clean_heredoc
        <ul>
          <li>Text</li>
          <li>Text</li>
        </ul>
      HTML

      html.should have_tag("li", :text => "Text", :exactly => 2)
    end

    it "fails when there are specified number of tags but with different text" do
      html = <<-HTML.clean_heredoc
        <ul>
          <li>Text</li>
          <li>Text2</li>
        </ul>
      HTML

      failure = <<-TEXT.clean_heredoc
        Expected exactly 2 fragment(s).
        Found 1 fragment(s):
          ?/ul/li[1]
            (no attributes)
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("li", :text => "Text", :exactly => 2)
      end
    end

    it "fails when there are more than specified number of tags with specific text" do
      html = <<-HTML.clean_heredoc
        <ul>
          <li>Text</li>
          <li>Text</li>
          <li>Text</li>
        </ul>
      HTML

      failure = <<-TEXT.clean_heredoc
        Expected exactly 2 fragment(s).
        Found 3 fragment(s):
          ?/ul/li[1]
            (no attributes)
            "Text"
          ?/ul/li[2]
            (no attributes)
            "Text"
          ?/ul/li[3]
            (no attributes)
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("li", :text => "Text", :exactly => 2)
      end
    end
  end

  describe "attributes and text" do
    it "passes when tag is found with specific text and matching attribute" do
      html = "<a href=\"google.com\">Text</a>"
      html.should have_tag("a", {:href => "google.com"}, :text => "Text")
    end

    it "fails when tag is found with matching text but different attribute" do
      html = "<a href=\"google.com\">Link</a>"

      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="yahoo.com".
        Found:
          ?/a
            href="google.com"
      TEXT

      should_raise failure do
        html.should have_tag("a", {:href => "yahoo.com"}, :text => "Link")
      end
    end

    it "fails when tag is found with matching attribute but different text" do
      html = "<a href=\"google.com\">Link</a>"

      failure = <<-TEXT.clean_heredoc
        Expected fragments with "Text" text.
        Found:
          ?/a
            "Link"
      TEXT

      should_raise failure do
        html.should have_tag("a", {:href => "google.com"}, :text => "Text")
      end
    end
  end
end