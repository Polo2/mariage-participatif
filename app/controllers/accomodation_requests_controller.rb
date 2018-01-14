class AccomodationRequestsController < ApplicationController
before_action :set_wedding
before_action :set_accomodation_request, only: [:edit, :destroy, :mark_as_complete]


  def new
    unless policy(@wedding).edit? || current_user.registries.last.accomodation_requests.count > 0
      @accomodation = Accomodation.find(params[:accomodation_id])
      @accomodation_request = AccomodationRequest.new
      @accomodation_request.accomodation = @accomodation
      case @accomodation.category
        when "amis"
        @accomodation_request.statut = false
        message = "Demande de logement chez des amis bien effectuée, on revient vers vous pour confirmer"
        when "hotel"
        @accomodation_request.statut = true
        message = "Merci de nous avoir confirmé dormir à l'hôtel"
        when "camping"
        @accomodation_request.statut = true
        message = "Merci, vive le camping, pensez à un duvet bien chaud"
        else
      end
      @accomodation_request.registry =  current_user.registries.last

      if @accomodation_request.save
        redirect_to wedding_path(@wedding), notice: message
      else
        redirect_to wedding_path(@wedding),  alert: "La demande de logement n'a pas été créée"
      end
    else
      redirect_to wedding_path(@wedding),  alert: "La demande de logement n'a pas pu être créée"
    end
  end


  def index
    @accomodations_pending_requests = @wedding.accomodation_requests.where(statut: false)
  end

  def edit
    @accomodation_request.statut = true
    if @accomodation_request.save
      redirect_to wedding_accomodation_requests_path(@wedding)
    end
  end

  def mark_as_complete

  end


  def destroy
    @accomodation_request.destroy
    redirect_to wedding_accomodation_requests_path(@wedding)
  end

  private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def set_accomodation_request
    @accomodation_request = AccomodationRequest.find(params[:id])
  end

end
