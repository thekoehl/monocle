class SensorsController < ApplicationController
  before_filter :authenticate_user!
  def show
    @sensor = current_user.sensors.where(id: params[:id]).first
    raise 'Could not find sensor' if @sensor.nil?
  end
end