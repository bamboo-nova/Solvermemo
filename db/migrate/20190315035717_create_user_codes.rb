class CreateUserCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :user_codes do |t|
      t.references :user, foreign_key: true
      t.references :code, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :code_id], unique: true
    end
  end
end
