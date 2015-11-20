class AddLongitudeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :longitude, :float
  end
end
