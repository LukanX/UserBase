class Interview < ActiveRecord::Base

  belongs_to :study
  belongs_to :participant

  validates :study_id, presence: true
  validates :participant_id, presence: true

  def participant_name
    @participant_name = Participant.find_by_id(self.participant_id).name
  end

end
