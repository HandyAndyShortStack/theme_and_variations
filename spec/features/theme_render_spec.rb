require 'spec_helper'

feature "Rendering a site with theme" do

  source = "https://s3-us-west-2.amazonaws.com/theme-and-variations/checked-theme/assets"

  background do
    switch_to_subdomain("sample-site")
    visit('/sample-url')
  end

  scenario "the page is the correct url" do
    expect(current_url).to eq("http://sample-site.lvh.me/sample-url")
  end

  scenario "the page has the site title" do
    within("#header .span7 h1") do
      expect(page).to have_content("Sample Site")
    end
  end

  scenario "title tag is output" do
    expect(page).to have_title("Sample Site - Sample Page")
  end

  scenario "meta tags are output" do
    expect(page).to have_meta(:robots, 'noindex, nofollow')
  end

  scenario "gwt tags are output" do
    expect(page).to have_css("#gwt", visible: false)
  end

  scenario "ga tags are output" do
    expect(page).to have_css("#gac")
  end

  scenario "closing tags are output" do
    expect(page).to have_css("#closing-tag")
  end

  scenario "styles are output" do
    expect(page).to have_css("style")
  end

  scenario "javascripts are output" do
    expect(page).to have_xpath("//script[@src = '#{source}/main.js']", visible: false)
  end

  scenario "images in layout are output" do
    expect(page).to have_xpath("//img[@src='#{source}/beach_ball.png']")
  end

  scenario "images in page template are output" do
    expect(page).to have_xpath("//img[@src='#{source}/lettuce.png']")
  end

  scenario "images in css are rendered" do
    expect(body).to have_content("background: url(#{source}/random_grey_variations.png);")
  end
end
