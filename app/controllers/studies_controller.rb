class StudiesController < ApplicationController
  before_filter :authenticate_user!
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
    @interviews = @study.interviews.all(order: 'scheduled_time ASC')
    @interview_dates = @interviews.group_by{ |t| t.scheduled_time.to_date }
  end

  def index
    if params[:tag].present? 
      @studies = Study.tagged_with(params[:tag])
    else
      @studies = Study.all
    end

    @study_months = @studies.sort_by(&:first_interview).reverse.group_by{ |t| t.first_interview.beginning_of_month }

  end

  def edit
    @study = Study.find(params[:id])
  end

  def update
    @study = Study.find(params[:id])
    if @study.update_attributes(study_parameters)
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
    params.require(:study).permit(:name, :date, :description, :id, :notes, :tag_list,
                                  interview_attributes:[:participant_id, :study_id, :scheduled_time, :id])
  end
end
