class AlarmsController < ActionController::Base
  layout 'application'

  ##################
  # Action Filters #
  ##################

  before_filter :authenticate_user!

  before_filter :populate_form_dropdowns, except: [ :index ]
  def populate_form_dropdowns
    @alarm_types = [ ['Low Level', 'low_level'] , ['High Level', 'high_level'] ]
    @sensor_options = current_user.numeric_sensors.map{ |t| [t.name, t.id] }

    return true
  end

  before_filter :verify_sensor_to_user_match, only: [ :create, :update ]
  def verify_sensor_to_user_match
    return true unless params[:alarm] && params[:alarm][:sensor_id]
    if current_user.numeric_sensors.where(id: params[:alarm][:sensor_id]).length == 0
      flash[:notice] = "That was not your sensor."
      return redirect_to alarms_path
    end
  end

  ####################
  # Instance Methods #
  ####################

  def create
    @alarm = Alarm.new alarm_params
    return redirect_to alarms_path if @alarm.save

    render :new
  end

  def destroy
    current_user.alarms.where(id: params[:id]).destroy_all
    return redirect_to alarms_path
  end

  def edit
    @alarm = current_user.alarms.find(params[:id])
    raise "Could not locate alarm by id #{params[:id]}" unless @alarm
  end

  def index
    @alarms = current_user.alarms.includes(:sensor).order("sensors.name ASC")
  end

  def new
    @alarm = Alarm.new
  end

  def update
    @alarm = current_user.alarms.find(params[:id])
    raise "Could not locate alarm by id #{params[:id]}" unless @alarm

    if @alarm.update_attributes(alarm_params)
      flash[:notice] = "Succesfully updated alarm."
      return redirect_to alarms_path
    end

    render :edit
  end

private

  def alarm_params
    params.require(:alarm).permit(:alarm_type, :sensor_id, :trigger_value)
  end


end
