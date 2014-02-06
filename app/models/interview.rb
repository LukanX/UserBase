class Interview < ActiveRecord::Base

  belongs_to :study
  belongs_to :participant

  validates :study_id, presence: true
  validates :participant_id, presence: true

end
