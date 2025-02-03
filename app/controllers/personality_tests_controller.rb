class PersonalityTestsController < ApplicationController
  def new
    @questions = Question.order(:id)
    @personality_test = PersonalityTest.new
  end

  def create
    @personality_test = PersonalityTest.new(personality_test_params)
    @result = @personality_test.get_result

    if @result
      redirect_to personality_test_path(@result.id)
    else
      flash[:alert] = "診断結果の取得に失敗しました。"
      render :new
    end
  end

  def show
    @result = Monk.find_by(id: params[:id])
    unless @result
      redirect_to new_personality_test_path
    end
  end

  private

  def personality_test_params
    params.require(:personality_test).permit(answers: {})
  end
end
