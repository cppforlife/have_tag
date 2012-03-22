require "spec_helper"

describe "Block syntax with_tag" do
  let(:html) do
    <<-HTML
      <html>
        <head>
          <title/>
        </head>
        <body>
      </html>
    HTML
  end

  describe "positive" do
    it "passes when tag is found within a context" do
      html.should have_tag("head") do
        with_tag("title")
      end
    end

    it "fails when tag is not found within a context" do
      failure = <<-TEXT.clean_heredoc
        Expected to find "body" in
        <title/>
      TEXT

      should_raise failure do
        html.should have_tag("head") do
          with_tag("body")
        end
      end
    end

    it "correctly scopes tag finding when multiple levels deep" do
      failure = <<-TEXT.clean_heredoc
        Expected to find "body" in
        <title/>
      TEXT

      should_raise failure do
        html.should have_tag("html") do
          with_tag("head") do
            with_tag("body")
          end
        end
      end
    end

    it "cannot be used outside of have_tag context" do
      should_raise "with_tag can only be used inside have_tag block" do
        with_tag("html")
      end
    end
  end

  describe "negative" do
    it "passes when tag is not found within a context" do
      html.should have_tag("head") do
        without_tag("body")
      end
    end

    it "fails when tag is found within a context" do
      failure = <<-TEXT.clean_heredoc
        Expected exactly 0 fragment(s).
        Found 1 fragment(s):
          ?/title
            (no attributes)
            ""
      TEXT

      should_raise failure do
        html.should have_tag("head") do
          without_tag("title")
        end
      end
    end

    it "correctly scopes tag finding when multiple levels deep" do
      html.should have_tag("html") do
        with_tag("head") do
          without_tag("body")
        end
      end
    end

    it "cannot be used outside of have_tag context" do
      should_raise "without_tag can only be used inside have_tag block" do
        without_tag("html")
      end
    end
  end

  it "can use other matchers inside the block" do
    html.should have_tag("head") do |head_html|
      head_html.should include "<title"
    end
  end
end
