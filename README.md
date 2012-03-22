have_tag matcher for HTML build on top of Nokogiri.

# Usage

    get "/home_page"
    response.should be_ok

    response.body.should have_tag "#account" do
      with_tag "a", :href => /log_out/
      without_tag "a", :href => /log_in/
    end

As shown above have_tag matcher operates on plain strings; however,
since it is mostly used with other testing libraries it can also be
called directly on `response` (RSpec) and `page` (Capybara) i.e.

    response.should have_tag...
    page.should have_tag

# RSpec integration:

    require "have_tag"
    RSpec.configure do |config|
      config.include HaveTag
    end

# More examples

    html.should have_tag "#header"

    html.should have_tag "span", :text => "exact text match"
    html.should have_tag "span", :text => /\d{3}-\d{4}/

    html.should have_tag "li", :exactly => 3
    html.should have_tag "li", :at_least => 1 # default
    html.should have_tag "li", :at_most => 10

    html.should have_tag "img", :src => "/exact/attribute/match.gif"
    html.should have_tag "img", :src => %r{beacon.gif}

    html.should have_tag "a", :href => "http://google.com", :target => "_blank"

    # using both attribute matching and text/count options
    html.should have_tag "li a", {:href => /\?product_id=\d+/}, {:text => /product/, :exactly => 10}

# Limiting by context

    html.should have_tag "#account" do |account_html|
      # account_html is plain string that holds inner html of #account
      account_html.should include "Welcome, Dmitriy Kalinin"

      account_html.should have_tag "a", :href => /logout/

      with_tag "a", :href => /logout/ # for convenience =)
    end

    html.should have_tag "#bank_balance.chart" do |chart_html, chart_attributes|
      chart_attributes["data-title"].should == "Bank balance"
      chart_attributes["data-values"].should == [33,293,38,93].join(",")

      with_tag ".legend" do
        with_tag "span.label", {:style => /color:/}, :exactly => 4
      end
    end

    page.should have_tag "ul#projects" do
      %w(Marketing Dev Support).each do |project|
        with_tag "li a", {:href => /projects\/#{project}/}, :text => project, :exactly => 1
      end
    end

    response.should have_tag :form, :action => signup_path, :method => :post do
      with_tag :input, :type => :text, :name => :email
      with_tag :input, :type => :password, :name => :password
      with_tag :input, :type => :submit
    end

# Todos

- make at_least and at_most work together
- keep on improving error reporting
