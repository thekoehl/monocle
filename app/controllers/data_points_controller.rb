class DataPointsController < ApplicationController
	def create
		begin
			raise "You must pass an api key for user[api_key]" if params[:user] == nil || params[:user][:api_key] == nil
			raise "You must pass a data_point[reporter]" if params[:data_point] == nil || params[:data_point][:reporter] == nil
			raise "You must pass data_points[units]" if params[:data_point] == nil || params[:data_point][:units] == nil
			raise "You must pass a data_point[value]" if params[:data_point] == nil || params[:data_point][:value] == nil
			raise "You must pass a sensor[name]" if params[:sensor] == nil || params[:sensor][:name] == nil

			@user = User.find_by_api_key params[:user][:api_key]
			raise "Non-existant user[api_key] passed." if @user == nil

			@data_point = DataPoint.new params[:data_point]
			@sensor = Sensor.find :first, :conditions => ["user_id = ? AND name = ?", @user.id, params[:sensor][:name]]
			if @sensor == nil
				@sensor = Sensor.new params[:sensor]
				@sensor.user = @user
			end

			if params[:sensor][:group_name] && @sensor.group_name != params[:sensor][:group_name]
				@sensor.group_name = params[:sensor][:group_name]
			end

			@data_point.sensor = @sensor

			@data_point.save!
			@sensor.save!

			render :json => {success: true, data_point: @data_point, sensor: @sensor}
		rescue Exception => ex
			render :json => {success: false, message: ex.message}
		end
	end
end
