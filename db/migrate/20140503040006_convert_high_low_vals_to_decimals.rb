class ConvertHighLowValsToDecimals < ActiveRecord::Migration
  def up
    change_column :sensors, :high_level, :decimal
    change_column :sensors, :low_level, :decimal
  end
  def down
    change_column :sensors, :high_level, :integer
    change_column :sensors, :low_level, :integer
  end
end
