class EditPartiicipantColumns < ActiveRecord::Migration
  def change
    remove_column :participants, :email
    remove_column :participants, :name

    add_column :participants, :email, :string, :null => false, :default => ""
    add_column :participants, :name, :string, :null => false, :default => ""
  end
end
