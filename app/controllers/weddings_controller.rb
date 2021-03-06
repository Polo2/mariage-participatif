class WeddingsController < ApplicationController
  before_action :set_wedding, only: [:show, :edit, :update]

  def show
    authorize(@wedding)
    @tasks_with_service = @wedding.tasks_with_service
    @tasks_without_service = @wedding.tasks_without_service

    unless policy(@wedding).edit?
      @registry = @wedding.registries.where(user: current_user).last # unless @wedding.registries.where(user: current_user).empty?
      @registry.update_score! if @registry
    end

    @markers = Gmaps4rails.build_markers([@wedding]) do |wedding, marker|
      marker.lat wedding.latitude
      marker.lng wedding.longitude
    end
  end

  def new
    @wedding = Wedding.new
    authorize(@wedding)
  end

  def edit
    authorize(@wedding)
  end

  def create
    @wedding = Wedding.new(wedding_params)
    @wedding.user = current_user
    authorize(@wedding)
    respond_to do |format|
      if @wedding.save
        format.html { redirect_to @wedding, notice: t("flash_messages.wedding-created") }
        format.json { render :show, status: :created, location: @wedding }
      else
        format.html { render :new }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize(@wedding)
    respond_to do |format|
      if @wedding.update(wedding_params)
        format.html { redirect_to @wedding, notice: t("flash_messages.wedding-updated") }
        format.json { render :show, status: :ok, location: @wedding }
      else
        format.html { render :edit }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def set_wedding
    @wedding = Wedding.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to weddings_path, notice: t("flash_messages.wedding-does-not-exist")
  end

  def wedding_params
    params.require(:wedding).permit(
      :description, :date, :deadline, :location, :photo, :spouse_photo,
      :first_name_1, :first_name_2
    )
  end
end
