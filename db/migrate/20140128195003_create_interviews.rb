class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.integer :study_id
      t.integer :participant_id
      t.datetime :scheduled_time

      t.timestamps
    end
  end
end
