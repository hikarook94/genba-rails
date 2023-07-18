class TasksController < ApplicationController
  def index
    # @tasks = Task.where(user_id: current_user.id)
    @tasks = current_user.tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    # @task = Task.new(task_params.merge(user_id: current_user.id))
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    # Rails7からレスポンスのリダイレクトにstatus: :see_otherをつける必要があるようです。
    # https://qiita.com/jnchito/items/5c41a7031404c313da1f#destroy%E3%81%AE%E3%83%AC%E3%82%B9%E3%83%9D%E3%83%B3%E3%82%B9%E3%81%AB-status-see_other-%E3%82%92%E4%BB%98%E3%81%91%E3%82%8B%E5%BF%85%E8%A6%81%E3%81%8C%E3%81%82%E3%82%8B
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。", status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
