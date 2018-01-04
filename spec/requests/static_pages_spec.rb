
require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Sample App') }
    it { should have_title(('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(('Contact')) }
  end
end

=begin
describe "StaticPages" do

  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

# The 'Home Page' is a description and rSpec does not care what it says
  describe "Home page" do
    it "It should have the content 'Sample App'" do
    # When I visit the home page, the content should contain the words Sample App
      visit root_path
      expect(page).to have_content('Sample App')
    end
  end

  describe "Help Page" do
    it "It should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end
  end

  describe "About Page" do
    it "About Us Page" do
      visit about_path
      expect(page).to have_content('About Us')
    end
  end

  describe "Contact Page" do
    it "Contact page content" do
      visit contact_path
      expect(page).to have_content("Contact")
    end

    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact")
    end
  end

end
=end
