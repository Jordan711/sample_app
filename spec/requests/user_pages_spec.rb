require 'spec_helper'

describe "User Pages -- " do
  subject {page}

  describe "Sign up Page -- " do
    before {visit signup_path}
    it {should have_selector('h1, ''Sign up')}
    it {should have_title('Sign up')}
  end
end
