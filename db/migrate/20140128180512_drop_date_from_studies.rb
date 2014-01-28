class DropDateFromStudies < ActiveRecord::Migration
  def change
    remove_column :studies, :date
  end
end
