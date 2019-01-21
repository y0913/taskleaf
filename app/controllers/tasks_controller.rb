class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy] #DRYに基づいて、重複を避ける。show, edit, update, destroyには同じ記述が・・・。only: []に対して:set_taskを適用するということ

  def index
    @q = current_user.tasks.ransack(params[:q])
  	# @tasks = current_user.tasks.order('created_at desc')
    @tasks = @q.result(distinct: true)
  end

  def show
  end

  def new
  	@task = Task.new
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end

  def create
  	@task = Task.new(task_params.merge(user_id: current_user.id)) #.merge 2つのハッシュを統合する

    if params[:back].present?
      render :new
      return
    end

  	if @task.save
  	 redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました"
    else
     render :new
    end
  end

  def edit
  end

  def update
  	@task.update!(task_params)
  	redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました。"
  end


  private

  def task_params
  	params.require(:task).permit(:name, :description)
  end

  def set_task #show, edit, update, destroyに対して適用する
    @task = current_user.tasks.find(params[:id])
  end
end
