require "spec_helper"

describe "Compatibility with different test subjects" do
  describe "for strings" do
    it "matches against response's body" do
      "<title/>".should have_tag "title"
    end
  end

  describe "for ActionDispatch::Response" do
    it "matches against response's body" do
      response = stub(:body => "<title/>")
      response.should have_tag "title"
    end
  end

  describe "for Capybara::Session" do
    it "matches against response's html" do
      page = stub(:html => "<title/>")
      page.should have_tag "title"
    end
  end
end