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
      @service.update(service_params)
      @service.task = @task
      redirect_to wedding_task_path(@wedding, @task) if @service.save
    else

      guest_list = register_guests(params[:service]["guest_ids"])

      if (guest_list.length + @service.guests.count ) <= @service.capacity
        guest_list.each do |g|
          g.service = @service
          g.save
        end
        @service.update(service_params)

        @service.task = @task
        if @service.save
          redirect_to wedding_task_path(@wedding, @task)
        end
      else
        redirect_to wedding_task_path(@wedding, @task), alert: "Désolé, pas assez de place sur ce service"
      end
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
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :capacity, :appointment)
  end

  def register_guests(array_guest_ids)
    array_ids = array_guest_ids.select{ |e| !e.empty? }.map{ |n| n.to_i }
    guests_array =  []
    array_ids.each { |id| guests_array << Guest.find(id) }
    return guests_array
  end




end
