class AddTimezoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :timezone, :string, null: false, default: ""
  end
end
