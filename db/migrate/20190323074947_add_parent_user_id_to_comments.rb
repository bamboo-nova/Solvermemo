class AddParentUserIdToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :parent_user_id, :string
  end
end
