class AddNotesToStudies < ActiveRecord::Migration
  def change
    add_column :studies, :notes, :text
  end
end
