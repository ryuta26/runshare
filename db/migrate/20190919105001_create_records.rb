class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.date :date
      t.decimal :content, precision: 6, scale: 2
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
