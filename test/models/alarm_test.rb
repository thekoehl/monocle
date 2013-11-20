require 'test_helper'

class AlarmTest < ActiveSupport::TestCase

	def setup
		@alarm = FactoryGirl.build(:alarm)
		@alarm.trigger_value = 5
		@alarm.save!

		@data_point = @alarm.sensor.data_points.build
		@data_point.value = 5
	end

	###############
	# Validations #
	###############

	test 'requires sensor' do
		@alarm.sensor = nil
		assert @alarm.save == false
	end

	test 'requires alarm type' do
		@alarm.alarm_type = nil
		assert @alarm.save == false
	end

	test 'requires trigger value' do
		@alarm.trigger_value = nil
		assert @alarm.save == false
	end

	test 'it autosets the user' do
		@alarm.save!
		assert @alarm.user == @alarm.sensor.user
	end

	test 'can save valid alarm' do
		assert @alarm.save == true
	end

  ####################
	# Instance Methods #
	####################

	test 'it does trigger high level when needed' do
		Timecop.freeze do
			@alarm.alarm_type = Alarm::ALARM_TYPES[:high_level]
			@alarm.save!

			@data_point.value = @alarm.trigger_value + 1
			@data_point.save!

			@alarm.reload

			assert @alarm.last_triggered_at.to_s == Time.now.utc.to_s
		end
	end

	test 'it does trigger low level when needed' do
		Timecop.freeze do
			@alarm.alarm_type = Alarm::ALARM_TYPES[:low_level]
			@alarm.save!

			@data_point.value = @alarm.trigger_value - 1
			@data_point.save!

			@alarm.reload

			assert @alarm.last_triggered_at.to_s == Time.now.utc.to_s
		end
	end

	test 'it does not spuriously trigger alarms' do
		@alarm.alarm_type = Alarm::ALARM_TYPES[:low_level]
		@alarm.save!

		@data_point.value = @alarm.trigger_value + 1 # note this is for a low level alarm
		@data_point.save!

		@alarm.reload

		assert @alarm.last_triggered_at == nil
	end

	test 'it does send notifications when needed' do
		Timecop.freeze do
			@alarm.alarm_type = Alarm::ALARM_TYPES[:low_level]
			@alarm.save!

			@data_point.value = @alarm.trigger_value - 1
			@data_point.save!

			@alarm.reload

			assert @alarm.last_triggered_at.to_s == Time.now.utc.to_s

			assert ActionMailer::Base.deliveries.empty? != true
			message = ActionMailer::Base.deliveries[0]
			assert message.subject == "Monocle Alert: #{@alarm.sensor.name} triggered an alarm at 4"
		end
	end

	test 'it does honor flapping detection' do
		@alarm.alarm_type = Alarm::ALARM_TYPES[:low_level]
		@alarm.save!

		@data_point.value = @alarm.trigger_value - 1
		@data_point.save!

		ActionMailer::Base.deliveries = []

		@data_point.value = @alarm.trigger_value - 1
		@data_point.save!

		assert ActionMailer::Base.deliveries.length == 0
	end

end
