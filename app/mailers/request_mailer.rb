class RequestMailer < ApplicationMailer


  def new_request(request)
    @accomodation_request = request
    @accomodation = request.accomodation
    @registry = request.registry
    @wedding = @accomodation.wedding

    mail(to: "polodile.mdb@gmail.com", subject: "Nouvelle demande de logement" )
  end
end
