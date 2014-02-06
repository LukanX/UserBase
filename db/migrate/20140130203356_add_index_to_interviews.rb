class AddIndexToInterviews < ActiveRecord::Migration
  def change
    add_index :interviews, :study_id
    add_index :interviews, :participant_id
    add_index :interviews, [:study_id, :participant_id], unique: true
  end
end
