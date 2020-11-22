# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_list
  before_action :set_task_list, only: %i[index]

  # GET /tasks
  # GET /tasks.json
  def index; end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @audits = @task.audits
  end

  # GET /tasks/new
  def new
    @task = @list.tasks.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @list.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to list_tasks_path(@list), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }

      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to list_tasks_path(@list), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to list_tasks_path(@list), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    if params[:task]
      params.require(:task).permit(:name, :completed, :list_id)
    else
      params.permit(:name, :completed, :list_id)
    end
  end

  def set_task_list
    if params[:completed]
      @tasks = @list.tasks.where(completed: task_params[:completed])
    else
      @tasks = @list.tasks.all
    end
  end
end
