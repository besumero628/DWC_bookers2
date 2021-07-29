class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :follower, foreign_key: true
      t.references :followed, foreign_key: true

      t.timestamps
    end
    
    add_foreign_key :relationships, :users, column: :follower_id
    add_foreign_key :relationships, :users, column: :followed_id
  end
end
