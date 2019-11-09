class RegistriesController < ApplicationController
  before_action :set_registry, only: [:show, :edit, :update, :destroy]
  before_action :set_wedding

  def index
    @registries = Registry.where('wedding_id = ?', @wedding.id ).order(:group_name)
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

private

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
