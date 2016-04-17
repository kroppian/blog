FactoryGirl.define do

  factory :article do

    user { FactoryGirl.create(:user) }
    title { ('a'..'z').to_a.shuffle[0,8].join }
    text "This is a generic post"

  end

end

