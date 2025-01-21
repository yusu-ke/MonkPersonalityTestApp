FactoryBot.define do
  factory :score_mapping do
    association :question
    option { 1 }
    score { 10 }
  end
end
