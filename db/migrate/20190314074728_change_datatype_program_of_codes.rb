class ChangeDatatypeProgramOfCodes < ActiveRecord::Migration[5.0]
  def change
    change_column :codes, :program, :text
  end
end
