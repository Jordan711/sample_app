require 'spec_helper'

#describe "StaticPages" do

#  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  # The 'Home Page' is a description and rSpec does not care what it says
#  describe "Home page" do
#    it "It should have the content 'Sample App'" do
      # When I visit the home page, the content should contain the words Sample App
#      visit '/static_pages/home'
#      expect(page).to have_content('Sample App')
#    end

#    it "It should have the content 'Help'" do
#      visit '/static_pages/help'
#      expect(page).to have_content('Help')
#    end

#    it "About Us Page" do
#      visit '/static_pages/about'
#      expect(page).to have_content('About Us')
#    end

#    it "Contact page content" do
#      visit '/static_pages/contact'
#      expect(page).to have_content("Contact")
#    end
#  end
describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the base title" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end
end
