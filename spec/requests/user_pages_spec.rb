require 'spec_helper'

describe "User Pages -- " do
  subject {page}
=begin
  THIS TESTING CODE SHOULD BE USED BUT FOR SOME REASON
  WHEN UNCOMMENTED, IT SHOWS THAT THE LINE WITH SIGN_IN DOES NOT HAVE EMAIL METHOD

  describe "index" do
    let (:user) {FactoryGirl.create(:user)}
    before (:each) do
      sign_in user
      visit users_path
    end

    it {should have_title('All users')}
    it {should have_content('All users')}

    describe "pagination" do
      before(:all) {30.times {FactoryGirl.create(:user)}}
      after(:all) {User.delete_all}

      it {should have_selector('div.pagination')}

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
      end
    end
  end
=end

  #TESTING CODE FROM THE PRIOR SECTION OF CHAPTER 9
  describe "index" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name: "Bob", email:"bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email:"ben@example.com")
      visit users_path
    end


    it {should have_title('All users')}
    it {should have_content('All users')}

    it 'Should list each user' do
      User.all.each do |user|
        expect(page).to have_selector('li', text: user.name)
    end
  end

    describe "delete links" do
      it {should_not have_link('delete')}

      describe "as an admin user" do
        let (:admin) {FactoryGirl.create(:admin)}
        before do
          sign_in admin
          visit users_path
        end

        it {should have_link('delete', href:user_path(User.first))}
        it "should be able to delete another user" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it {should_not have_link('delete', href:user_path(admin))}
      end
    end
  end

  describe "Profile page" do
    let(:user) {FactoryGirl.create(:user, name:"Billy bob", email:"g@gggg.g")}
    let!(:m1) {FactoryGirl.create(:micropost, user: user, content: "foo")}
    let!(:m2) {FactoryGirl.create(:micropost, user: user, content: "bar")}

    before {visit user_path(user)}

    it {should have_content(user.name)}
    it {should have_title(user.name)}

    describe "microposts" do
      it {should have_content(m1.content)}
      it {should have_content(m2.content)}
      it {should have_content(user.microposts.count)}
    end
  end

  describe "signup page" do
    before {visit signup_path}
    it {should have_selector('h1, ''Sign up')}
    it {should have_title(full_title('Sign up'))}
    it {should_not have_link('Profile')}
    it {should_not have_link('Settings')}
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
      it {should_not have_link('Profile')}
      it {should_not have_link('Settings')}
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
      it {should_not have_link('Profile')}
      it {should_not have_link('Settings')}
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
      it {should_not have_link('Profile')}
      it {should_not have_link('Settings')}
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
      it {should_not have_link('Profile')}
      it {should_not have_link('Settings')}
    end
  end

  describe "edit" do
    let(:user) {FactoryGirl.create(:user, name: "wack", email:"zacky@wacky.com")}
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it {should have_content("Update your profile")}
      it {should have_title("Edit User")}
      it {should have_link("change", href: 'http://gravatar.com/emails')}
    end

    describe "with invalid information" do
      before {click_button "Save changes"}
      it {should have_content('error')}
    end

    describe "with valid information" do
      let (:new_name) {"New Name"}
      let (:new_email) {"new@example.com"}

      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it {should have_title(new_name)}
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }

      specify {expect(user.reload.name).to eq new_name}
      specify {expect(user.reload.email).to eq new_email}
    end
  end
end
