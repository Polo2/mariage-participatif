require 'json'

class TasksController< ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_wedding



  def index
    @tasks = Task.where wedding: @wedding
    @task = Task.new
  end


  def show
    @services = @task.services
    @service = Service.new

    @messages = @task.messages.order(:created_at).reverse

    @messages.each {|m| m.update_as_read } if policy(@wedding).edit?

    @message = Message.new

    @list_guests_adults = current_user.registries.last.guests.where(child: false).where(presence: true) unless current_user == @wedding.user
    @list_guests_adults_without_service = @list_guests_adults.select { |g| !g.service_id?  } unless current_user == @wedding.user
  end

  def create
    @task = Task.new(task_params)
    @task.wedding_id = @wedding.id
    @task.statut = false
    if @task.save
      redirect_to wedding_tasks_path(@wedding)
    end
  end

  def edit
    @task.update(statut: !@task.statut)
    redirect_to wedding_path(@wedding)
  end

  def update
  end

  def destroy
    @task.destroy
    redirect_to wedding_path(@wedding)
  end

  def upload
    @nb_tasks = @wedding.tasks.count
    Task.where('wedding_id = ?', @wedding.id).destroy_all

    @clean_service_list = cleaning_service_json(import_tasks_from_json)
    creating_new_tasks_from_hash(@clean_service_list)
    redirect_to wedding_path(@wedding)

  end

  def update_all_as_read(messages)
    @messages = messages
    @messages.each do |m|
      m.read == true
      m.save
    end
  end

private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_wedding
    @wedding = Wedding.find(params[:wedding_id])
  end

  def task_params
    params.require(:task).permit(:name)
  end

  def parsing_json
    file = File.read("#{Rails.root}/lib/tasks_details/details.json")
    old_service_details = JSON.parse(file)
    return old_service_details
  end

  def import_tasks_from_json
    file = File.read("#{Rails.root}/lib/tasks_details/DB-services-v2.json")
    service_details = JSON.parse(file)
    return service_details
  end

  def cleaning_service_json(hash)
    name_list = []
    good_hash = {}
    services_as_array = hash[hash.keys.first]
    services_as_array.each { |service| name_list << service["type"] unless name_list.include?(service["type"]) }
    name_list.each { |s_name| good_hash[s_name] = [] }
    services_as_array.each do |service|
      good_hash[service["type"]] << {
        day: service["day"],
        time: service["time"],
        location: service["location"],
        capacity: service["capacity"].to_i,
        details: service["details"]
      }
    end
    good_hash
  end

  def creating_new_tasks_from_hash(hash_task)
    hash_task.each do |t_name, t_services|
      new_task = Task.new(name: t_name, wedding: @wedding, statut: false)
      new_task.save
      t_services.each do |service|
        Service.create( name: service[:day], capacity: service[:capacity], appointment: service[:time] , task: new_task, day: service[:day], location: service[:location], details: service[:details]  )
      end
    end
  end
end
