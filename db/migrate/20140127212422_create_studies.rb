class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.string :name, :null => false, :default => ""
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
