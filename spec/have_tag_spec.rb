require "spec_helper"

describe HaveTag do
  describe "positive" do
    it "passes when tag is found" do
      "<link/>".should have_tag "link"
    end

    it "fails when tag is not found" do
      failure = <<-TEXT.clean_heredoc
        Expected to find "table" in
        <link/>
      TEXT

      should_raise failure do
        "<link/>".should have_tag "table"
      end
    end
  end

  describe "negative" do
    it "passes when tag is not found" do
      "<link/>".should_not have_tag "a"
    end

    it "fails when tag is not found" do
      failure = <<-TEXT.clean_heredoc
        Expected exactly 0 fragment(s).
        Found 1 fragment(s):
          ?/link
            (no attributes)
            ""
      TEXT

      should_raise failure do
        "<link/>".should_not have_tag "link"
      end
    end

    it "does not support specifying count" do
      should_raise "count option is not supported for negative assertions" do
        "<link/>".should_not have_tag "link", :exactly => 1
      end
    end
  end

  it "passes when multiple tags are found" do
    "<link/><link/>".should have_tag "link"
  end

  it "passes when tag is found at non-root level" do
    "<head><link/></head>".should have_tag "link"
  end

  it "accepts selector as a symbol" do
    "<link/>".should have_tag :link
  end
end
