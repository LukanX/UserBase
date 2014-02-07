class Interview < ActiveRecord::Base

  require 'Date'

  before_save :convert_to_datetime

  belongs_to :study
  belongs_to :participant

  validates :study_id, presence: true
  validates :participant_id, presence: true


  def sched_date_field
    scheduled_time.strftime("%d/%m/%Y") if scheduled_time.present?
  end 

  def sched_time_field
    scheduled_time.strftime("%I:%M %p") if scheduled_time.present?
  end

  def sched_date_field=(date)
    # Change back to datetime friendly format
    @sched_date_field = Date.strptime(date, "%m/%d/%Y").strftime("%Y-%m-%d")
  end

  def sched_time_field=(time)
    # Change back to datetime friendly format
    @sched_time_field = Time.parse(time).utc.strftime("%H:%M:%S")
  end

  def convert_to_datetime
    self.scheduled_time = DateTime.parse("#{@sched_date_field} #{@sched_time_field}")
  end

  def participant_name
    @participant_name = Participant.find_by_id(self.participant_id).name
  end

end
