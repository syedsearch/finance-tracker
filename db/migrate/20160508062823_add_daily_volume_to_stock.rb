class AddDailyVolumeToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :daily_volume, :string
  end
end
