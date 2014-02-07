class ChangeScheduledTimeToTime < ActiveRecord::Migration
  def change
    remove_column :interviews, :scheduled_time

    add_column :interviews, :scheduled_time, :time
  end
end
