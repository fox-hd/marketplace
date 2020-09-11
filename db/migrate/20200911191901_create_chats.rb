class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.references :order, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
