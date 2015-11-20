class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :city
      t.integer :zipcode
      t.string :country
      t.text :story

      t.timestamps null: false
    end
  end
end
