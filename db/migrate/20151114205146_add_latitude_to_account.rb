class AddLatitudeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :latitude, :float
  end
end
