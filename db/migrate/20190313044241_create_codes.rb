class CreateCodes < ActiveRecord::Migration[5.0]
  def change
    create_table :codes do |t|
      t.references :user, foreign_key: true
      t.string :summary
      t.string :program
      t.string :data
      t.string :content

      t.timestamps
    end
  end
end
