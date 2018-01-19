require 'json'

class RegistriesController < ApplicationController
  before_action :set_registry, only: [:show, :edit, :update, :destroy]
  before_action :set_wedding

  def index
    @registries = Registry.where('wedding_id = ?', @wedding.id )
  end

  def show
    @registry = @wedding.registries.find(params[:id])
  end

  def new
    @registry = Registry.new
    @registry.guests.build
  end

  def create
    @registry = Registry.new(registry_params)
    @registry.guests.each { |g|  g.presence = nil }
    @registry.wedding = @wedding
    if @registry.save
      redirect_to wedding_registry_path(@wedding, @registry)
    else
      render :new
    end
  end

  def edit
  end

  def update
    # current_user.registries.find(params[:registry_id])
    @registry.update(registry_params)
    if current_user == @wedding.user || current_user == @registry.user
      redirect_to wedding_registry_path(@wedding, @registry)
    else
      redirect_to wedding_path(@wedding)
    end
  end

  def destroy
    @registry.destroy
    redirect_to wedding_registries_path(@wedding, @registry)
  end

  def upload
    Registry.where('wedding_id = ?', @wedding.id).destroy_all
    count_registry = new_registries(import_registries_from_json).count
    count_guests = new_guests(import_registries_from_json).count
    redirect_to wedding_path(@wedding), notice: "#{count_registry} invitations, pour #{count_guests} invités !"
  end

  private

  def import_registries_from_json
    file = File.read("#{Rails.root}/lib/registries_details/DB-registries.json")
    registries_details = JSON.parse(file)
    return registries_details["DB-registrations"]
  end

  def new_guests(all_guest_list)

    all_guest_list.each do |guest|
      g = Guest.new({
        name: guest["prenom"],
        presence: nil,
        child: false,
      })
      g.registry = @wedding.registries.where(email: guest["email"]).last
      g.save
    end
    @wedding.guests
  end


  def new_registries(all_guest_list)
    mailing_list = []
    # good_hash = {}
    all_guest_list.each { |guest| mailing_list << {"email" => guest["email"], "group_name" => guest["nom de famille"]} unless mailing_list.include?({"email" => guest["email"], "group_name" => guest["nom de famille"]}) }
    mailing_list.each do |reg_email|
      registry = Registry.new({
        email: reg_email["email"],
        group_name: reg_email["group_name"]
        })
      registry.wedding = @wedding
      registry.save
    end
    return mailing_list.map { |reg| reg["email"] }
  end


  def set_registry
    @registry = Registry.find(params[:id])
  end

  def registry_params
    params.require(:registry).permit(:email, :group_name, :address, :zipcode, :city, guests_attributes: [:id, :name, :presence, :child, :_destroy])
  end

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end



end
