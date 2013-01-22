# == Schema Information
#
# Table name: data_points
#
#  id                 :integer          not null, primary key
#  value              :integer
#  reporter           :string(255)
#  sensor_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  units              :string(255)
#  created_at_monthly :string(255)
#  created_at_hourly  :string(255)
#  created_at_daily   :string(255)
#

require 'test_helper'

class DataPointTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
