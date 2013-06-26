# Responsible for cleaning out old motion events

require 'rake'
namespace :monocle do
	desc "Clean old camera events"
	task :clean_old_camera_events => :environment do
		puts "Starting to clean old camera events..."
		CameraEvent.where('created_at < ?', Time.now - 24.hours).destroy_all
	end
end