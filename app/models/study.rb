class Study < ActiveRecord::Base

  has_many :interviews, dependent: :destroy
  has_many :participants, :through => :interviews

  accepts_nested_attributes_for :interviews
  acts_as_taggable

  require 'date'
  validates :name, presence: true

  def date_range
    @date_range ||= []
    self.interviews.all(order: 'scheduled_time ASC').each do |t|
      @date_range.push(t.scheduled_time.to_date)
    end
    return @date_range
  end

  def first_interview
    date_range.first
  end
end
