namespace :monocle do
  desc "Run through the sensors and check for signal faults"
  task :check_signal_faults => :environment do
    Sensor.all.each do |s|
      s.check_for_and_trigger_alarm
    end
  end
end