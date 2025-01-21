require 'rails_helper'

RSpec.describe PersonalityTest do
  it "診断機能において正しい結果とマッチする" do
    question = create(:question)
    create(:score_mapping, question:question, option: 1, score: 5)
    monk = create(:monk, start_score: 0, end_score: 10)
    answers = { question.id.to_s => "1" }
    
    personality_test = PersonalityTest.new(answers: answers)
    result = personality_test.get_result
    expect(result).to eq(monk)  
  end
end
