class ChangeDataParentUserIdToComments < ActiveRecord::Migration[5.0]
  def change
    change_column :comments, :parent_user_id, :int
  end
end
