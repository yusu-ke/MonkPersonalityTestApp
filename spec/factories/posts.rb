FactoryBot.define do
  factory :post do
    sequence(:, temple_name "example_place")
    comment { "comment" }

    association :user
  end
end