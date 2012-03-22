require "spec_helper"

describe "Count option integration" do
  describe "with exactly zero" do
    let(:html) { "<a href=\"google.com\">Text</a>" }

    it "passes when tag is not found" do
      html.should have_tag("link", :exactly => 0)
    end

    it "passes when tag is not found with matching attributes" do
      html.should have_tag("a", {:href => "yahoo.com"}, :exactly => 0)
    end

    it "passes when tag is not found with matching text" do
      html.should have_tag("a", :text => "other-text", :exactly => 0)
    end

    it "passes when tag is not found with specific text and matching attributes" do
      html.should have_tag("a", {:href => "google.com"}, :text => "other-text", :exactly => 0)
    end

    it "fails when tag is found" do
      failure = <<-TEXT.clean_heredoc
        Expected exactly 0 fragment(s).
        Found 1 fragment(s):
          ?/a
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", :exactly => 0)
      end
    end

    it "fails when tag is found with matching attributes" do
      failure = <<-TEXT.clean_heredoc
        Expected exactly 0 fragment(s).
        Found 1 fragment(s):
          ?/a
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", {:href => "google.com"}, :exactly => 0)
      end
    end

    it "fails when tag is found with matching text" do
      failure = <<-TEXT.clean_heredoc
        Expected exactly 0 fragment(s).
        Found 1 fragment(s):
          ?/a
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", :text => "Text", :exactly => 0)
      end
    end

    it "fails when tag is found with matching attributes and text" do
      failure = <<-TEXT.clean_heredoc
        Expected exactly 0 fragment(s).
        Found 1 fragment(s):
          ?/a
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", {:href => "google.com"}, :text => "Text", :exactly => 0)
      end
    end
  end

  describe "with at least zero" do
    let(:html) { "<a href=\"google.com\">Text</a>" }

    it "passes when tag is not found" do
      html.should have_tag("link", :at_least => 0)
    end

    it "passes when tag is not found with matching attributes" do
      html.should have_tag("a", {:href => "yahoo.com"}, :at_least => 0)
    end

    it "passes when tag is not found with matching text" do
      html.should have_tag("a", :text => "other-text", :at_least => 0)
    end

    it "passes when tag is not found with specific text and matching attributes" do
      html.should have_tag("a", {:href => "google.com"}, :text => "other-text", :at_least => 0)
    end

    it "passes when tag is found" do
      html.should have_tag("a", :at_least => 0)
    end

    it "passes when tag is found with matching attributes" do
      html.should have_tag("a", {:href => "google.com"}, :at_least => 0)
    end

    it "passes when tag is found with matching text" do
      html.should have_tag("a", :text => "Text", :at_least => 0)
    end

    it "passes when tag is found with matching attributes and text" do
      html.should have_tag("a", {:href => "google.com"}, :text => "Text", :at_least => 0)
    end
  end

  describe "with at least 1" do
    let(:html) { "<a href=\"google.com\">Text</a>" }

    it "passes when tag is found" do
      html.should have_tag("a", :at_least => 1)
    end

    it "passes when tag is found with matching attributes" do
      html.should have_tag("a", {:href => "google.com"}, :at_least => 1)
    end

    it "passes when tag is found with matching text" do
      html.should have_tag("a", :text => "Text", :at_least => 1)
    end

    it "passes when tag is found with matching attributes and text" do
      html.should have_tag("a", {:href => "google.com"}, :text => "Text", :at_least => 1)
    end

    it "fails when tag is not found with matching attributes" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="yahoo.com".
        Found:
          ?/a
            href="google.com"
      TEXT

      should_raise failure do
        html.should have_tag("a", {:href => "yahoo.com"}, :at_least => 1)
      end
    end

    it "fails when tag is not found with matching text" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with "other-text" text.
        Found:
          ?/a
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", :text => "other-text", :at_least => 1)
      end
    end

    it "fails when tag is not found with matching attributes and text" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="yahoo.com".
        Found:
          ?/a
            href="google.com"
      TEXT

      should_raise failure do
        html.should have_tag("a", {:href => "yahoo.com"}, :text => "other-text", :at_least => 1)
      end
    end
  end

  describe "with at most zero" do
    let(:html) { "<a href=\"google.com\">Text</a>" }

    it "passes when tag is not found" do
      html.should have_tag("link", :at_most => 0)
    end

    it "passes when tag is not found with matching attributes" do
      html.should have_tag("a", {:href => "yahoo.com"}, :at_most => 0)
    end

    it "passes when tag is not found with matching text" do
      html.should have_tag("a", :text => "other-text", :at_most => 0)
    end

    it "passes when tag is not found with specific text and matching attributes" do
      html.should have_tag("a", {:href => "google.com"}, :text => "other-text", :at_most => 0)
    end

    it "fails when tag is found" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 0 fragment(s).
        Found 1 fragment(s):
          ?/a
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", :at_most => 0)
      end
    end

    it "fails when tag is found with matching attributes" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 0 fragment(s).
        Found 1 fragment(s):
          ?/a
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", {:href => "google.com"}, :at_most => 0)
      end
    end

    it "fails when tag is found with matching text" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 0 fragment(s).
        Found 1 fragment(s):
          ?/a
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", :text => "Text", :at_most => 0)
      end
    end

    it "fails when tag is found with matching attributes and text" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 0 fragment(s).
        Found 1 fragment(s):
          ?/a
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        html.should have_tag("a", {:href => "google.com"}, :text => "Text", :at_most => 0)
      end
    end
  end

  describe "with at most 1" do
    let(:html) { "<a href=\"google.com\">Text</a>" }

    it "passes when tag is not found" do
      html.should have_tag("link", :at_most => 1)
    end

    it "passes when tag is not found with matching attributes" do
      html.should have_tag("a", {:href => "yahoo.com"}, :at_most => 1)
    end

    it "passes when tag is not found with matching text" do
      html.should have_tag("a", :text => "other-text", :at_most => 1)
    end

    it "passes when tag is not found with specific text and matching attributes" do
      html.should have_tag("a", {:href => "google.com"}, :text => "other-text", :at_most => 1)
    end

    it "passes when tag is found" do
      html.should have_tag("a", :at_most => 1)
    end

    it "passes when tag is found with matching attributes" do
      html.should have_tag("a", {:href => "google.com"}, :at_most => 1)
    end

    it "passes when tag is found with matching text" do
      html.should have_tag("a", :text => "Text", :at_most => 1)
    end

    it "passes when tag is found with matching attributes and text" do
      html.should have_tag("a", {:href => "google.com"}, :text => "Text", :at_most => 1)
    end

    it "fails when multiple tags are found" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 1 fragment(s).
        Found 2 fragment(s):
          ?/a[1]
            href="google.com"
            "Text"
          ?/a[2]
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        (html+html).should have_tag("a", :at_most => 1)
      end
    end

    it "fails when multiple tags are found with matching attributes" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 1 fragment(s).
        Found 2 fragment(s):
          ?/a[1]
            href="google.com"
            "Text"
          ?/a[2]
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        (html+html).should have_tag("a", {:href => "google.com"}, :at_most => 1)
      end
    end

    it "fails when multiple tags are found with matching text" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 1 fragment(s).
        Found 2 fragment(s):
          ?/a[1]
            href="google.com"
            "Text"
          ?/a[2]
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        (html+html).should have_tag("a", :text => "Text", :at_most => 1)
      end
    end

    it "fails when multiple tags are found with matching attributes and text" do
      failure = <<-TEXT.clean_heredoc
        Expected at most 1 fragment(s).
        Found 2 fragment(s):
          ?/a[1]
            href="google.com"
            "Text"
          ?/a[2]
            href="google.com"
            "Text"
      TEXT

      should_raise failure do
        (html+html).should have_tag("a", {:href => "google.com"}, :text => "Text", :at_most => 1)
      end
    end
  end
end