require 'test_helper'

class DataPointTest < ActiveSupport::TestCase
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
