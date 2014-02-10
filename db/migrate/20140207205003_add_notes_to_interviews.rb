class AddNotesToInterviews < ActiveRecord::Migration
  def change
    add_column :interviews, :notes, :string
  end
end
