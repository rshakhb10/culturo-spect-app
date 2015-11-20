class AddNewArrivalToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :new_arrival, :boolean
  end
end
