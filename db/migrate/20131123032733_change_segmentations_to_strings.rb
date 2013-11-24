# This was a huge oversight on my part.  Existing data is saved with created_at using
# UTC.  The subsequent data migration should successfully back-create all the pre-computed
# fields.
class ChangeSegmentationsToStrings < ActiveRecord::Migration
  def change
    change_column :data_points, :hourly_segmentation, :string
    change_column :data_points, :daily_segmentation, :string
    change_column :data_points, :monthly_segmentation, :string

    puts "Migrating datapoints to new compute format... this could take awhile..."
    DataPoint.all.each do |dp|
      tn = dp.created_at.in_time_zone(Rails.configuration.time_zone)

      dp.hourly_segmentation  = tn.strftime("%Y/%m/%d %H:00 (%a)")
      dp.daily_segmentation   = tn.strftime("%Y/%m/%d (%a)")
      dp.monthly_segmentation = tn.strftime("%Y/%m")

      dp.save(validate: false)
    end
  end
end
