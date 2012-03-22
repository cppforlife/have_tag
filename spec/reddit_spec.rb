require "spec_helper"

describe "Reddit integration spec" do
  it "uses have_tag against real html page" do
    html = IO.read(File.dirname(__FILE__) + "/fixtures/reddit.html")

    html.should have_tag :meta, :name => :description, :content => /^reddit/
    html.should have_tag :link, :rel => :icon, :href => /icon.png$/

    # accessibility
    html.should have_tag "a:first", :href => "#content"
    html.should have_tag "a", :name => "content"

    html.should have_tag ".tabmenu" do
      %w(new controversial top saved).each do |link|
        with_tag "li a", {:href => %r!#{link}/$!}, :text => link
      end
    end

    html.should have_tag ".login-required", :href => %r{https://ssl.+/login}

    html.should have_tag :form, :method => :post, :action => %r{https://ssl.+/post/login} do
      with_tag :input, :type => :hidden, :name => :op
      with_tag :input, :type => :text, :name => :user
      with_tag :input, :type => :password, :name => :passwd
      with_tag :input, :type => :checkbox, :name => :rem
      with_tag :button, :type => :submit
    end

    html.should have_tag "#ad-frame", :scrolling => :no

    html.should have_tag :select, :name => :lang do
      with_tag :option, :exactly => 54
    end
  end
end