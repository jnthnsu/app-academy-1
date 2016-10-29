FactoryGirl.define do
  factory :user do
    username{Faker::Name.name}
    password{Faker::Lorem.characters(7)}

    factory :user_no_password do
      password nil
    end
  end
end
