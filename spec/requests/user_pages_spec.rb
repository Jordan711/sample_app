require 'spec_helper'

describe "User Pages -- " do
  subject {page}

  describe "Profile page" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}

    it {should have_content(user.name)}
    it {should have_title(user.name)}
  end

  describe "signup page" do
    before {visit signup_path}
    it {should have_selector('h1, ''Sign up')}
    it {should have_title(full_title('Sign up'))}
  end

  describe "signup" do
    before {visit signup_path}

    let(:submit) {"Create my account"}

    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "b@b.net"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect {click_button submit}.to change(User, :count).by(1)
      end

      describe "after saving user" do
        before {click_button submit}

        let (:user) { User.find_by(email: 'b@b.net') }

        it {should have_title(user.name)}
        it {should have_link('Sign out')}
        it {should have_selector('div.alert.alert-success', text: 'Welcome')}
      end
    end

    describe "after submission" do
      before {click_button submit}

      it {should have_title('Sign up')}
      it {should have_content('error')}
    end

    describe "empty name" do
      before do
        fill_in "Email", with: "b@b.net"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
        click_button submit
      end

      it {should have_title('Sign up')}
      it {should have_content('error')}
    end

    describe "empty email" do
      before do
        fill_in "Name", with: "Bob"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
        click_button submit
      end

      it {should have_title('Sign up')}
      it {should have_content('error')}
    end

    describe "empty password" do
      before do
        fill_in "Name", with: "Tom"
        fill_in "Email", with: "b@b.net"
        fill_in "Password", with: ""
        fill_in "Confirmation", with: "foobar"
        click_button submit
      end

      it {should have_title('Sign up')}
      it {should have_content('error')}
    end

    describe "non matching passwords" do
      before do
        fill_in "Name", with: "Thomas"
        fill_in "Email", with: "b@b.net"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "fobar"
        click_button submit
      end

      it {should have_title('Sign up')}
      it {should have_content('error')}
    end
  end
end
