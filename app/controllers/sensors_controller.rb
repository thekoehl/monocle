class SensorsController < ApplicationController
  ############
  # Concerns #
  ############
  include Chartable

  ###########
  # Filters #
  ###########
  before_filter :authenticate_user!
  before_filter :load_sensor!
  def load_sensor!
    @sensor = current_user.sensors.includes(:last_data_point).where(id: params[:id]).first
    raise 'Could not find sensor' if @sensor.nil?
  end

  ###########
  # Actions #
  ###########
  def edit; end

  def show
    @data = chart_data # Provided by Chartable
    @maximum = @sensor.data_points.maximum(:value)
    @minimum = @sensor.data_points.minimum(:value)
  end

  def update
    # Why are we clearing this?  If the user is browsing the sensor;
    # then they have seen any issues and should be reminded if they
    # didn't fix it.
    @sensor.last_notification_sent_at = nil
    if @sensor.update_attributes(sensor_params)
      flash[:notice] = "Succesfully updated sensor."
      return redirect_to sensor_path(@sensor)
    end
    render :edit
  end

private

  def sensor_params
    params.require(:sensor).permit(:high_level, :low_level, :signal_fault_delay, :needs_attention)
  end

end
