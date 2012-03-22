require "spec_helper"

describe "Count option" do
  let(:html) { "<ul><li/><li>Foo</li></ul>" }

  describe "exact" do
    it "passes when tag appears 0 times when specified" do
      "<ul/>".should have_tag("li", :exactly => 0)
    end

    it "fails when tag appears more than required number of times" do
      failure = <<-TEXT.clean_heredoc
        Expected exactly 1 fragment(s).
        Found 2 fragment(s):
          ?/ul/li[1]
            (no attributes)
            ""
          ?/ul/li[2]
            (no attributes)
            "Foo"
      TEXT

      should_raise failure do
        html.should have_tag("li", :exactly => 1)
      end
    end

    it "passes when tag appears exact number of times" do
      html.should have_tag("li", :exactly => 2)
    end

    it "fails when tag appears less than required number of times" do
      failure = <<-TEXT.clean_heredoc
        Expected exactly 3 fragment(s).
        Found 2 fragment(s):
          ?/ul/li[1]
            (no attributes)
            ""
          ?/ul/li[2]
            (no attributes)
            "Foo"
      TEXT

      should_raise failure do
        html.should have_tag("li", :exactly => 3)
      end
    end
  end

  describe "at least" do
    it "passes when tag appears 0 times" do
      "<ul/>".should have_tag("li", :at_least => 0)
    end

    it "passes when tag appears more than required number of times" do
      html.should have_tag("li", :at_least => 1)
    end

    it "passes when tag appears specified number of times" do
      html.should have_tag("li", :at_least => 2)
    end

    it "fails when tag appears less than required number of times" do
      failure = <<-TEXT.clean_heredoc
        Expected at least 3 fragment(s).
        Found 2 fragment(s):
          ?/ul/li[1]
            (no attributes)
            ""
          ?/ul/li[2]
            (no attributes)
            "Foo"
      TEXT

      should_raise failure do
        html.should have_tag("li", :at_least => 3)
      end
    end
  end

  describe "at most" do
    it "passes when tag appears 0 times" do
      "<ul/>".should have_tag("li", :at_most => 0)
    end

    it "fails when tag appears more than required number of times" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 1 fragment(s).
        Found 2 fragment(s):
          ?/ul/li[1]
            (no attributes)
            ""
          ?/ul/li[2]
            (no attributes)
            "Foo"
      TEXT

      should_raise failure do
        html.should have_tag("li", :at_most => 1)
      end
    end

    it "passes when tag appears specified number of times" do
      html.should have_tag("li", :at_most => 2)
    end

    it "passes when tag appears less than required number of times" do
      html.should have_tag("li", :at_most => 3)
    end
  end
end
