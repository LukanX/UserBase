class SearchController < ApplicationController
  
  def index
    if params[:term].present?
      @participants = Participant.tagged_with(params[:term])
      @studies = Study.tagged_with(params[:term])
      @interviews = Interview.tagged_with(params[:term])
      @term = "#{params[:term]}"
      @results = @participants + @studies + @interviews

      like= "%".concat(params[:term].concat("%"))
      @tags = ActsAsTaggableOn::Tag.where("name ilike ?", like)
    else
      @tags = ActsAsTaggableOn::Tag.all
    end
    list = @tags.map {|u| Hash[label: u.name, name: u.name]}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: list }
    end
  end

end
