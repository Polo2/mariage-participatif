class ServicesController < ApplicationController
before_action :set_wedding
before_action :set_task
before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    @services = Service.where('wedding_id = ? AND task_id = ?', @wedding.id, @task.id)
  end

  def show
  end

  def new
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
    @service.update(service_params)
    @service.task = @task
    if @service.save
      redirect_to wedding_task_path(@wedding, @task)
    end
  end

  def destroy
    @service.destroy
    redirect_to wedding_task_path(@wedding, @task)
  end


private

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_service
    @service = service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :capacity, :appointment)
  end

end
