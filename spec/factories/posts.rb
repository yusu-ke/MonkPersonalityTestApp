FactoryBot.define do
  factory :post do
    sequence(:temple_name, "example_place")
    comment { "comment" }

    association :user

    after(:build) do |post|
      post.map ||= build(:map, post: post)
    end
  end
end
