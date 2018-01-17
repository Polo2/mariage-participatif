class VegetablesController < ApplicationController
before_action :set_wedding
before_action :set_registry, only: [:new, :create]
  def index
    @vegetables = @wedding.vegetables
  end

  def new
    @vegetable = Vegetable.new
  end

  def create
    @vegetable = Vegetable.new(vegetable_params)
    @vegetable.registry = @registry
    if @vegetable.save
      redirect_to wedding_vegetables_path(@wedding), notice: "Miam !"
    else
      redirect_to wedding_path(@wedding), error: "Aïe : petit probleme en cuisine ..."
    end
  end

  private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def set_registry
    @registry = current_user.registries.last unless policy(@wedding).edit?
  end

  def vegetable_params
    params.require(:vegetable).permit(:name, :slogan, :capacity, :photo)
  end

end
