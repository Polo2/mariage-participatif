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

    @guests_without_service = guests_without_service
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

  def guests_without_service
    return if policy(@wedding).edit?
    current_user.registry_for_wedding(@wedding)
      .guests
      .where_service_is_required
  end
end
