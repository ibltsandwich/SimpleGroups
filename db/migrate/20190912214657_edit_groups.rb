class EditGroups < ActiveRecord::Migration[5.2]
  def change
    change_column_null :groups, :owner_id, false
  end
end
