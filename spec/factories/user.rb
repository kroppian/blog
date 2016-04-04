
FactoryGirl.define do

  factory :user do

    id { rand(1..1_000_000) }
    email { ('a'..'z').to_a.shuffle[0,8].join + "@gmail.com" }
    name "paul"
    password 'lamepassword'
    password_confirmation 'lamepassword'
    about "I'm just a guy, you know?" 
    user_type 0 

  end

end

