FactoryGirl.define do
  factory :user do
    #Create a new user by these parameters
    #name     "Michael Hartl"
    #email    "michael@example.com"
    #password "foobar"
    #password_confirmation "foobar"

    #Utilizing this method, we can overcome the issue of duplicate email addresses
    sequence(:name) {|n| "Person #{n}"}
    sequence(:email) {|n| "person_#{n}@mail.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem Ipsum"
    user
  end
end
