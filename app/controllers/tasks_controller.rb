class TasksController < ApplicationController

	def new 
		@task = current_user.tasks.build

		render :show_form
	end

	def create
	  @task = current_user.tasks.build(task_params)
	  save_task
	end

	def edit
  	@task = Task.find(params[:id])

  	render :show_form
	end

	def update
	  @task = Task.find(params[:id])
	  @task.assign_attributes(task_params)
	  save_task
	end

	def destroy
		@task = Task.find(params[:id])
  	@task.destroy
  	@tasks = Task.all
	end

	def complete
		@task = Task.find(params[:id])
		@task.update_attributes(:completed_at, Time.now)
		redirect_to tasks_path
	end

	def uncomplete
		@task = Task.find(params[:id])
		@task.update_attributes(:completed_at, nil)
		redirect_to tasks_path
	end

	private

	def save_task
	  if @task.save
	    @tasks = Task.all
	    render :hide_form
	  else

	    render :show_form
	  end
	end

	def task_params
		params.require(:task).permit(:title, :note, :completed)
	end
end
