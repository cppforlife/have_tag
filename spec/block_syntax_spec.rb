require "spec_helper"

describe "Block syntax" do
  let(:html) do
    <<-HTML
      <html data-color="white">
        <head>
          <title/>
        </head>
        <body>
      </html>
    HTML
  end

  it "passes when tag is found within a context" do
    html.should have_tag("head") do |head_html|
      head_html.should have_tag("title")
    end
  end

  it "fails when tag is not found within a context" do
    failure = <<-TEXT.clean_heredoc
      Expected to find "body" in
      <title/>
    TEXT

    should_raise failure do
      html.should have_tag("head") do |head_html|
        head_html.should have_tag("body")
      end
    end
  end

  it "does not find itself within a context" do
    failure = <<-TEXT.clean_heredoc
      Expected to find "head" in
      <title/>
    TEXT

    should_raise failure do
      html.should have_tag("head") do |head_html|
        head_html.should have_tag("head")
      end
    end
  end

  it "does not fail when context starts with text node" do
    html = "<p>Text <b>bold</b></p>"

    html.should have_tag("p") do |paragraph_html|
      paragraph_html.should have_tag("b")
    end
  end

  it "does not require arguments" do
    should_raise "from-inside" do
      html.should have_tag("head") do
        raise "from-inside"
      end
    end

    should_raise "from-inside" do
      html.should have_tag("head") do ||
        raise "from-inside"
      end
    end
  end

  describe "tag attributes (two arguments)" do
    it "provides access to tag's attributes through second block parameter" do
      html.should have_tag("html") do |html_html, attributes|
        attributes["data-color"].should == "white"
      end
    end
  end
end
