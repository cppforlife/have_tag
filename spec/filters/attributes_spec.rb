require "spec_helper"

describe "Attributes matching" do
  context "with one attribute" do
    let(:html) { "<a href=\"google.com\"/>" }

    it "passes when tag's attribute matches provided attribute" do
      html.should have_tag "a", :href => "google.com"
    end

    it "fails when tag's attribute does not match provided attribute" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="yahoo.com".
        Found:
          ?/a
            href="google.com"
      TEXT

      should_raise failure do
        html.should have_tag "a", :href => "yahoo.com"
      end
    end

    it "fails when tag does not have provided attribute" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="yahoo.com".
        Found:
          ?/a
            (no attributes)
      TEXT

      should_raise failure do
        "<a/>".should have_tag "a", :href => "yahoo.com"
      end
    end

    it "accepts attribute name as a string" do
      html.should have_tag "a", "href" => "google.com"
    end

    it "accepts attribute value as a symbol" do
      html.should have_tag "a", :href => :"google.com"
    end
  end

  context "with multiple attributes" do
    let(:html) { "<a href=\"google.com\" rel=\"nofollow\"/>" }

    it "passes when tag's attributes match all provided attributes" do
      html.should have_tag "a", :href => "google.com", :rel => "nofollow"
    end

    it "fails when tag's attributes do not match one of provided attributes" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="google.com", rel="friend".
        Found:
          ?/a
            href="google.com", rel="nofollow"
      TEXT

      should_raise failure do
        html.should have_tag "a", :href => "google.com", :rel => "friend"
      end
    end
  end

  describe "nil matching" do
    it "passes when tag does not have attribute" do
      "<a/>".should have_tag "a", :href => nil
    end

    it "fails when tag has attribute" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="".
        Found:
          ?/a
            href="google.com"
      TEXT

      should_raise failure do
        "<a href=\"google.com\"/>".should have_tag "a", :href => nil
      end
    end

    it "fails when tag has empty attribute" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="".
        Found:
          ?/a
            href=""
      TEXT

      should_raise failure do
        "<a href=\"\"/>".should have_tag "a", :href => nil
      end
    end
  end

  describe "regex matching" do
    let(:html) { "<a href=\"google.com\"/>" }

    it "passes when tag's attribute matches provided attribute" do
      html.should have_tag "a", :href => /\.com$/
    end

    it "fails when tag's attribute does not match provided attribute" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="(?-mix:^http:)".
        Found:
          ?/a
            href="google.com"
      TEXT

      should_raise failure do
        html.should have_tag "a", :href => /^http:/
      end
    end

    it "fails when tag does not have provided attribute" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="(?-mix:^http:)".
        Found:
          ?/a
            (no attributes)
      TEXT

      should_raise failure do
        "<a/>".should have_tag "a", :href => /^http:/
      end
    end

    it "passes when tag's attribute is empty and regex matches anything" do
      "<a href=\"\"/>".should have_tag "a", :href => //
    end

    it "fails when tag does not have provided attribute regex matches anything" do
      failure = <<-TEXT.clean_heredoc
        Expected fragments with attribute(s) href="(?-mix:)".
        Found:
          ?/a
            (no attributes)
      TEXT

      should_raise failure do
        "<a/>".should have_tag "a", :href => //
      end
    end
  end
end