server ENV['PRODUCTION_DEPLOYMENT_SERVER'], user: ENV['PRODUCTION_DEPLOYMENT_USER'], roles: %w{web app db}
set :deploy_to, ENV['PRODUCTION_DEPLOY_TO']