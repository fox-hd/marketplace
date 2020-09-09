class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :profile, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
