class InterviewsController < ApplicationController

  def new
    @study = Study.find_by_id(params[:study_id])
    @interview = @study.interviews.build
  end

  def create
    @study = Study.find_by_id(params[:study_id])
    @interview = @study.interviews.build(interview_parameters)
    Time.zone = current_user.timezone
    if @interview.save
        flash[:success] = "Interview Saved!"
        redirect_to study_path(@study)
    else
      render 'new'
    end
  end

  def show
    @study = Study.find_by_id(params[:study_id])
    @interview = @study.interviews.find(params[:id])
  end

  def destroy
    @study = Study.find_by_id(params[:study_id])
    @interview = @study.interviews.find(params[:id]).destroy
    flash[:success] = "Interview Deleted"
    redirect_to study_path(@study)
  end

  def edit
    @study = Study.find_by_id(params[:study_id])
    @interview = @study.interviews.find(params[:id])
  end

  def update
    @study = Study.find_by_id(params[:study_id])
    @interview = @study.interviews.find(params[:id])
    Time.zone = current_user.timezone
    if @interview.update_attributes(interview_parameters)
      flash[:success] = "Interview Updated"
      redirect_to study_interview_path
    else
      render edit
    end
  end

  def index
    if params[:tag].present?
      @interviews = Interview.tagged_with(params[:tag])
    else
      @interviews = Interview.all
    end
  end

  private

  def interview_parameters
    params.require(:interview).permit(:participant_id, :study_id, :scheduled_time, :sched_time_field, :sched_date_field, :notes, :tag_list)                            
  end

end
