class AddDayAndHourFieldsToDataPoints < ActiveRecord::Migration
	def change
        change_table :data_points do |t|
        	t.string :created_at_monthly
            t.string :created_at_hourly
            t.string :created_at_daily
        end
        DataPoint.all.each do |dp|
        	dp.units = "N" if dp.units == nil
        	dp.created_at_monthly = dp.created_at.utc.strftime("%Y/%m")
        	dp.created_at_daily = dp.created_at.utc.strftime("%Y/%m/%d")
        	dp.created_at_hourly = dp.created_at.utc.strftime("%Y/%m/%d %H")
        	dp.save!
        end
	end
end
