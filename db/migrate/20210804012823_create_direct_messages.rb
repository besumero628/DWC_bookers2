class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.references :send_user, foreign_key: { to_table: :users } #DMする人
      t.references :receive_user, foreign_key: { to_table: :users } #DMされる人
      t.text :message

      t.timestamps
      
      add_foreign_key :direct_messages, :users, column: :send_user_id
      add_foreign_key :direct_messages, :users, column: :receive_user_id
    end
  end
end
