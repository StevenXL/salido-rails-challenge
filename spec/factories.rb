require 'faker'

FactoryGirl.define do
  factory :wine_type do
    name Faker::Lorem.word
  end

  factory :varietal do
    name Faker::Lorem.word
    wine_type
  end

  factory :region do
    name Faker::Lorem.word
  end

  factory :appellation do
    name Faker::Lorem.word
    region
  end

  factory :vineyard do
    name Faker::Lorem.word
  end

  factory :wine do
    name Faker::Lorem.word
    price_max 50
    price_min 25
    price_retail (26...50).to_a.sample
    appellation
    varietal
    vineyard
  end
end
