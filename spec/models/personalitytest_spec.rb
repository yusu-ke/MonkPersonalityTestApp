require 'rails_helper'

RSpec.describe PersonalityTest do
  it "診断機能において正しい結果とマッチするか" do
    # 質問作成
    question = create(:question)
    # スコアマッピング作成
    create(:score_mapping, question:question, option: 1, score: 5)
    # 診断結果作成
    monk = create(:monk, start_score: 0, end_score: 10)
    # ユーザー回答データ
    answers = { question.id.to_s => "1" }
    
    personality_test = PersonalityTest.new(answers: answers)
    result = personality_test.get_result
    expect(result).to eq(monk)  
  end
end
