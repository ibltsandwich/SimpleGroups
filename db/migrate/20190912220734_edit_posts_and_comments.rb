class EditPostsAndComments < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :username, :string, null: false, default: ''
    add_column :comments, :username, :string, null: false, default: ''
  end
end
