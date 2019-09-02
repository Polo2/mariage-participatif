class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @question = Question.new
    @user = user_signed_in? ? current_user : nil
  end
end
