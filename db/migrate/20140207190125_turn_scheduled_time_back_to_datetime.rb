class TurnScheduledTimeBackToDatetime < ActiveRecord::Migration
  def change
    remove_column :interviews, :scheduled_time

    add_column :interviews, :scheduled_time, :datetime
  end
end
