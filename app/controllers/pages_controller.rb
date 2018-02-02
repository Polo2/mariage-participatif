class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @question = Question.new
    user_signed_in? ? @user = current_user : @user = nil
    # @wedding_polodile = Wedding.find(23)
  end

end
