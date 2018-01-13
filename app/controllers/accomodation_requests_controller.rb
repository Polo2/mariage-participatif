class AccomodationRequestsController < ApplicationController
before_action :set_wedding


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

  def create

  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

end
