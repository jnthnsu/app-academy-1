FactoryGirl.define do
  factory :goal do
    title {Faker::Name.name}
    details {Faker::Name.name}
  end
end
