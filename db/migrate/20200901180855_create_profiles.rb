class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :nick_name
      t.date :date_of_birth
      t.string :department
      t.string :role
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :cpf

      t.timestamps
    end
  end
end
