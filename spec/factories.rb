require 'faker'

FactoryGirl.define do
  factory :wine_type do
    name Faker::Lorem.word
  end
end
