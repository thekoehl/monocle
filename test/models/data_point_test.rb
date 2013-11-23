require 'test_helper'

class DataPointTest < ActiveSupport::TestCase

  test 'it computes proper statistical references' do
    Rails.configuration.time_zone = 'Central Time (US & Canada)' # I'm assuming these tests won't be ran in Auckland
    Timecop.freeze do
      d = Time.find_zone('Central Time (US & Canada)').local(2013, 11, 13, 1,23,0)
      Timecop.travel(d)

      dp = FactoryGirl.create(:data_point)

      assert dp.hourly_segmentation == "2013/11/13 01:00 (Wed)", "Got: '#{dp.hourly_segmentation}'"
      assert dp.daily_segmentation == "2013/11/13 (Wed)"
      assert dp.monthly_segmentation == "2013/11"
    end
  end

  test 'it computes statistical references based off of the configured timezone' do    
    Rails.configuration.time_zone = 'Auckland' # I'm assuming these tests won't be ran in Auckland
    Timecop.freeze do
      time_now = Time.now.in_time_zone(Rails.configuration.time_zone)
      proposed_segmentation = time_now.strftime("%Y/%m")

      dp = FactoryGirl.create(:data_point)
      assert dp.monthly_segmentation = proposed_segmentation
    end
  end

end
