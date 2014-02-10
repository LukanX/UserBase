class ChangeNotesToText < ActiveRecord::Migration
  def change
    change_column :interviews, :notes, :text
  end
end
