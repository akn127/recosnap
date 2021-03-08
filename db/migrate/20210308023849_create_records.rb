class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.references :user,        null: false, foreign_key: true
      t.string :title,           null: false
      t.integer :category_id,    null: false
      t.date :date,              null: false
      t.string :place,           null: false
      t.string :with
      t.text :text
      t.string :url
      t.integer :status,         null: false
      t.timestamps
    end
  end
end
