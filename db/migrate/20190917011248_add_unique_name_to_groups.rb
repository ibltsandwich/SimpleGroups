class AddUniqueNameToGroups < ActiveRecord::Migration[5.2]
  def change
    change_column :groups, :name, :string, unique: true
  end
end
