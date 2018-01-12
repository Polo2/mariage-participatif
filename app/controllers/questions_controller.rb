class QuestionsController < ApplicationController

  def new
  end

  def create
    @question = Question.new(params.require(:question).permit(:name, :email, :message))
    if @question.save
      redirect_to root_path
    end

  end

end
