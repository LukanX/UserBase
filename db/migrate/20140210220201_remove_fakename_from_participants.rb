class RemoveFakenameFromParticipants < ActiveRecord::Migration
  def change
    remove_column :participants, :fakename
  end
end
