class Interview < ActiveRecord::Base

  before_save :convert_to_datetime

  belongs_to :study
  belongs_to :participant

  validates :study_id, presence: true
  validates :participant_id, presence: true
  acts_as_taggable


  def sched_date_field
    scheduled_time.strftime("%m/%d/%Y") if scheduled_time.present?
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
    @sched_time_field = Time.zone.parse(time).strftime("%H:%M:%S %z")
  end

  def future_offset
    @future_offset ||= Time.parse(@sched_date_field).utc_offset
  end

  def present_offset
    @present_offset ||= Time.now.utc_offset
  end

  def dst_compensation
    @dst_compensation ||= present_offset - future_offset
  end

  def convert_to_datetime
    self.scheduled_time = DateTime.parse("#{@sched_date_field} #{@sched_time_field}").utc + dst_compensation.seconds
  end

  def participant_name
    Participant.find_by_id(self.participant_id).name if participant_id.present?
  end

end
