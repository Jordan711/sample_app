require 'spec_helper'

describe "StaticPages" do
  # The 'Home Page' is a description and rSpec does not care what it says
  describe "Home page" do
    it "It should have the content 'Sample App'" do
      # When I visit the home page, the content should contain the words Sample App
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "It should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

    it "About Us Page" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end

    it "should have title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
    end

    it "should have title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end

    it "should have title 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About")
    end
  end
end
