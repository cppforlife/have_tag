require "spec_helper"

describe "Text option" do
  let(:html) do
    <<-HTML
      <ul>
        <li/>
        <li>Text1</li>
        <li>\nText2\n</li>
      </ul>
    HTML
  end

  describe "string matching" do
    it "passes when tag's content matches in its entirety" do
      html.should have_tag("li", :text => "Text2")
    end

    it "fails when tag's content partially matches" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with "Text" text.
        Found:
          ?/ul/li[1]
            ""
          ?/ul/li[2]
            "Text1"
          ?/ul/li[3]
            "Text2"
      TEXT

      should_raise failure do
        html.should have_tag("li", :text => "Text")
      end
    end

    it "fails when tag's content does not match" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with "Not-there-text" text.
        Found:
          ?/ul/li[1]
            ""
          ?/ul/li[2]
            "Text1"
          ?/ul/li[3]
            "Text2"
      TEXT

      should_raise failure do
        html.should have_tag("li", :text => "Not-there-text")
      end
    end
  end

  describe "regex matching" do
    it "passes when tag's content matches" do
      html.should have_tag("li", :text => /2$/)
    end

    it "fails when tag's content does not match" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with "(?-mix:something)" text.
        Found:
          ?/ul/li[1]
            ""
          ?/ul/li[2]
            "Text1"
          ?/ul/li[3]
            "Text2"
      TEXT

      should_raise failure do
        html.should have_tag("li", :text => /something/)
      end
    end
  end
end
