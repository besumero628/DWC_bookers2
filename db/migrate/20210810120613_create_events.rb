class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :group_id
      t.string :subject, null: false
      t.text :message, null: false

      t.timestamps
    end
  end
end
