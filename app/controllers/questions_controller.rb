class QuestionsController < ApplicationController

skip_before_action :authenticate_user!

  def create
    @question = Question.new(params.require(:question).permit(:name, :email, :message))
    if @question.save
      redirect_to root_path, notice: "Merci pour votre message"
    else
      render "pages/home", error: "Votre message n'a pas pu nous arriver"
    end
  end

end
