class DiscussionsController < ApplicationController
  before_action :set_wedding

  def show
    @discussion = Discussion.find(params[:id])
    @messages = @discussion.messages
    @message = Message.new
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new discussion_params.merge(wedding: @wedding)
    if @discussion.save
      redirect_to wedding_discussion_path(@wedding, @discussion)
    else
      render :new
    end
  end

  private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def discussion_params
    params.require(:discussion).permit(:name)
  end
end
