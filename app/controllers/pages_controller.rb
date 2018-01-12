class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @question = Question.new
    user_signed_in? ? @user = current_user : @user = nil
  end

end
