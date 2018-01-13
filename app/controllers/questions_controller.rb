class QuestionsController < ApplicationController


  def create
    @question = Question.new(params.require(:question).permit(:name, :email, :message))
    if @question.save
      redirect_to root_path
    else
      render "pages/home"
    end
  end

end
