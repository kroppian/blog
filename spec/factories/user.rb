
FactoryGirl.define do

  factory :user do

    email "paul@gmail.com"
    name "paul"
    password_digest "#{User.digest('lamepassword')}"
    about "I'm just a guy, you know?" 
    user_type 0 

  end

end

