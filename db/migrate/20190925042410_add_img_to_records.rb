class AddImgToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :img, :string
  end
end
