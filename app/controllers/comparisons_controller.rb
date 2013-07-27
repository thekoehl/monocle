class ComparisonsController < ApplicationController
	before_filter :authenticate_user!
	def create
		@comparison = Comparison.new
		assign_attributes_to_dashboard

		unless @comparison.valid?
			@sensors = current_user.sensors
			return render :new
		end

		@comparison.save!
		flash[:notice] = "Comparison saved."
		return redirect_to comparisons_path
	end
  def destroy
    @comparison = current_user.comparisons.find_by_id params[:id]
    raise "That's an invalid comparison." if @comparison.nil?

    @comparison.delete
    flash[:notice] = "comparison has been deleted."
    return redirect_to comparisons_path
  end
	def edit
		@comparison = current_user.comparisons.find_by_id params[:id]
		raise "That's an invalid comparison" if @comparison.nil?

		@sensors = current_user.sensors
	end
	def index
		@comparisons = current_user.comparisons
	end
	def new
		@comparison = Comparison.new
		@sensors = current_user.sensors
	end
	def show
		@comparison = current_user.comparisons.find_by_id params[:id]
		raise "That's an invalid comparison." if @comparison.nil?

		@sensor_ids = @comparison.sensors.map {|s| s.id }.join(',')
		@sensor_names = @comparison.sensors.map {|s| s.name }.join(',')
		@sensor_units = @comparison.sensors.first.nil? ? '' : @comparison.sensors.first.data_points.last.units
	end
	def update
		@comparison = current_user.comparisons.find_by_id params[:id]
		raise "That's an invalid comparison." if @comparison.nil?

		assign_attributes_to_dashboard

		unless @comparison.valid?
			@sensors = current_user.sensors
			return render :edit
		end
		@comparison.save!
		flash[:notice] = "Reporting Dashboard saved."
		return redirect_to comparisons_path
	end
private
	def assign_attributes_to_dashboard
		raise "You must create a class level @reporting_dashboard first." if @comparison.nil?
		@comparison.title = params[:comparison][:title]
		@comparison.user = current_user

		@comparison.sensors.clear
		return if params[:comparison][:sensor_ids].nil?

		params[:comparison][:sensor_ids].each do |sensor_id|
			sensor = current_user.sensors.find_by_id sensor_id
			raise "Could not locate sensor by id #{sensor_id}" if sensor.nil?
			@comparison.sensors << sensor
		end
	end
end
