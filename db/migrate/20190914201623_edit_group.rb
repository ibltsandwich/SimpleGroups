class EditGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :owner_name, :string, null: false, default: ''
  end
end
