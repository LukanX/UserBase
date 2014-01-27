class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.string :fakename
      t.string :email
      t.string :gender
      t.string :income
      t.integer :age

      t.timestamps
    end
  end
end
