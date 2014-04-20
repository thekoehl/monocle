require File.expand_path("../environment", __FILE__)
ENV['RAILS_ENV'] ||= 'development'

# Set some variables
set :environment, ENV['RAILS_ENV']
set :identifier, "cakes_#{environment}"

# Update path if we're on a server using capistrano
dir = Rails.root.to_s.split('/').last
if dir == 'current' ||
   dir.match(/\A[\d]{14}\Z/)
  # We are in the capistrano 'releases' and can use 'current'
  path = File.join(File.expand_path('../../../..', __FILE__), 'current')
else
  path = Rails.root.to_s
end
set :path, path


# Setup logging paths
set :output, { :standard => File.join(path, "log/cron.log"),
               :error    => File.join(path, "log/cron-error.log") }

# Detect if we are using chruby
chruby = "/usr/local/share/chruby/chruby.sh"
if File.file?(chruby)
  # Get the ruby version from the project
  ruby_version = File.read(Rails.root.join(".ruby-version")).to_s.strip

  # Setup template for jobs using chruby
  cmd_prefix = "source #{chruby} && chruby #{ruby_version} &&"
  set :job_template, "bash -l -c '#{cmd_prefix} :job'"
end

every :hour do
  rake 'monoclecheck_signal_faults'
end