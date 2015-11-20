class ChangeZipcodeToString < ActiveRecord::Migration
  def change
  	change_column :accounts, :zipcode, :string
  end
end
