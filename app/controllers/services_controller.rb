class ServicesController < ApplicationController
  before_action :set_wedding
  before_action :set_task, except: [:index]
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    if policy(@wedding).edit?
      @services = @wedding.services
    else
      @services = current_user.registries.last.services
      @guests = current_user.registries.last.guests.where(child: false, presence: true)
    end
  end

  def show
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.task = @task
    if @service.save
      redirect_to wedding_task_path(@wedding, @task)
    end
  end

  def edit
  end

  def update
    if policy(@wedding).edit?
      if @service.update service_params.merge(task_id: @task.id)
        redirect_to wedding_task_path(@wedding, @task)
      else
        render :edit
      end
    else
      if guests_ids.length <= @service.remaining_places_count
        guests_ids.each do |guest_id|
          Guest.find(guest_id).update service: @service
        end
        redirect_to wedding_task_path(@wedding, @task), notice: "Merci du coup de main, inscription réussie"
      else
        redirect_to wedding_task_path(@wedding, @task), alert: "Désolé, pas assez de place sur ce service"
      end
    end
  end

private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(
      :description, :capacity, :location, :start_at, :stop_at
    )
  end

  def guests_ids
    params[:service]["guest_ids"].reject(&:empty?).map(&:to_i)
  end
end
