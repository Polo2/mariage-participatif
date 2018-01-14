require 'json'

class AccomodationsController < ApplicationController
  before_action :set_wedding

  def index
    @accomodations = Accomodation.where('wedding_id = ?', @wedding.id)
  end

  def upload
    Accomodation.destroy_all
    @accomodations_list = parsing_json["accomodations-DB"]
    creating_new_accomodations_from_array(@accomodations_list)
    redirect_to wedding_path(@wedding)
  end


  def edit
    @accomodation = @wedding.accomodations.find(params[:id])
    @accomodation.complete = true
    if @accomodation.save
      redirect_to wedding_accomodations_path(@wedding), notice: "Logement marqué comme complet"
    else
      redirect_to wedding_accomodations_path(@wedding), error: "Erreur pour marquer ce logement comme complet"
  end

  private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def parsing_json
    file = File.read("#{Rails.root}/lib/accomodations_details/accomodations-DB-v2.json")
    accomodations_details = JSON.parse(file)
    return accomodations_details
  end

  def creating_new_accomodations_from_array(array)
    array.each do |accom|
      Accomodation.create(
        name: accom["name"],
        location: accom["location"],
        contact_name: accom["contact_name"],
        contact_email: accom["contact_email"],
        contact_website: accom["contact_url"],
        contact_phone: accom["contact_phone"],
        distance: accom["distance"],
        category: accom["type"],
        complete: false,
        wedding: @wedding )
    end
  end

end
