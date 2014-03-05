class ParticipantsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)
    if @participant.save
      flash[:success] = "Participant Saved"
      redirect_to @participant
    else
      render new
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def index
    if params[:tag].present? 
      @participants = Participant.tagged_with(params[:tag])
    elsif params[:term].present?
      like= "%".concat(params[:term].concat("%"))
      @participants = Participant.where("name ilike ?", like)
    else 
      @participants = Participant.all
    end

    list = @participants.map {|u| Hash[ id: u.id, label: u.name + ' (' + u.email + ')', name: u.name]}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: list }
    end
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(participant_params)
      flash[:success] = "Participant Updated"
      redirect_to @participant
    else
      render edit
    end
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def destroy
    Participant.find(params[:id]).destroy
    flash[:success] = "Participant Deleted"
    redirect_to participants_path
  end

  def tagged
    if params[:tag].present? 
      @participants = Participant.tagged_with(params[:tag])
    else 
      @participants = Participant.all
    end  
  end

  private

  def participant_params
    params.require(:participant).permit(:name, :email, :gender, :age, :income, :tag_list,
                                        interview_attributes:[:id, :scheduled_time])
  end
end
