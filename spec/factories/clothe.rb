FactoryBot.define do
  factory :clothe do
    association :brand_name
    category { rand(3) }
    gender { rand(2) }
  end
end
