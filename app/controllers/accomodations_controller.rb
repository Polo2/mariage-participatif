class AccomodationsController < ApplicationController
  before_action :set_wedding

  def index
    @accomodations = Accomodation.where('wedding_id = ?', @wedding.id).order(:distance)
  end

private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end
end
