# == Schema Information
#
# Table name: alarms
#
#  id             :integer          not null, primary key
#  sensor_id      :integer
#  active         :boolean
#  trigger_value  :integer
#  trigger_type   :string(255)
#  last_triggered :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class AlarmTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
