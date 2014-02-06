class StudiesController < ApplicationController
  def new
    @study = Study.new
  end

  def create
    @study = Study.new(study_parameters)
    if @study.save
      flash[:success] = "Study Created"
      redirect_to @study
    else
      render new
    end
  end

  def show
    @study = Study.find(params[:id])
  end

  def index
    @studies = Study.all
  end

  def edit
    @study = Study.find(params[:id])
  end

  def update
    @study = Study.find(params[:id])
    if @study.update_attributes(study_params)
      flash[:success] = "Study Updated"
      redirect_to @study
    else
      render edit
    end
  end

  def destroy
    Study.find(params[:id]).destroy
    flash[:success] = "Study Deleted"
    redirect_to studies_path
  end

  private

  def study_parameters
    params.require(:study).permit(:name, :date, :description, :id,
                                  interview_attributes:[:participant_id, :study_id, :scheduled_time, :id])
  end
end
