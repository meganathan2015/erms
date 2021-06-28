class EmployeeTimesheetsController < ApplicationController
  before_action :set_employee_timesheet, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token
  MINUTES_PER_DAY = 24*60

  # GET /employee_timesheets or /employee_timesheets.json
  def index
    if current_user.role == "admin"
      # @user_managements = UserManagement.order(:first_name).page params[:page]
      @employee_timesheets = EmployeeTimesheet.order(:project_name).page params[:page]

      # @employee_timesheets = EmployeeTimesheet.all
    else 
      @employee_timesheets = EmployeeTimesheet.where(user_id: current_user.id).order("time_sheet_date desc").page params[:page]
    end
    @project = Project.new
    @projects = Project.all
  end

  # GET /employee_timesheets/1 or /employee_timesheets/1.json
  def show
  end

  def time_elapsed(start_str, finish_str)
    start_mins = time_str_to_minutes(start_str)  
    finish_mins = time_str_to_minutes(finish_str)
    finish_mins += MINUTES_PER_DAY if
      finish_mins < start_mins
    (finish_mins-start_mins).divmod(60)
  end
  
  def time_str_to_minutes(str)
    hrs, mins = str.split(':').map(&:to_i)
    60 * hrs + mins
  end


  def employee_retrieve_data
    @thours = time_elapsed(params[:start_time], params[:end_time])
    @total_hours_data = @thours.join(":")
    # @total_hours_data = @thours.gsub(",",":")

    respond_to do |format|
      format.html
      format.js {} 
      format.json { 
         render json: {:total_time => @total_hours_data}
      } 
    end
  end
  # GET /employee_timesheets/new
  def new
    @employee_timesheet = EmployeeTimesheet.new
  end

  # GET /employee_timesheets/1/edit
  def edit
  end

  def spent_total_hours(emp_new_array, hour_spent)
  
    c = emp_new_array + hour_spent
    mins = c.sum do |s|
      h, m = s.split(':').map(&:to_i)
      60*h + m
    end
      #=> 337
    hm = mins.divmod(60)
      #=> [5, 37]
    @hour_mins = hm.join('.')
    # @total_hours_spent = hm.join(':')
      #=> "5:37"
   
  end

  def new_data_update(new_data_update,no_spend_time)
    # spend_time = no_spend_time.split(" ")
    
    c = new_data_update + no_spend_time
   
    mins = c.sum do |s|
    h, m = s.split(':').map(&:to_i)
        60*h + m
    end
      #=> 337
    hm = mins.divmod(60)
      #=> [5, 37]
    @hour_mins = hm.join('.')
    # @total_hours_spent = hm.join(':')
  end

  # POST /employee_timesheets or /employee_timesheets.json
  def create
    @employee_timesheet = EmployeeTimesheet.new(employee_timesheet_params)
    params_spend_of_time = params[:employee_timesheet][:spend_of_time]
    new_spent_hours = params_spend_of_time.split(" ")
    employee = User.find(params[:employee_timesheet][:user_id])
    emp_data_in_table = EmployeeTimesheet.where(user_id: employee.id, time_sheet_date: params[:employee_timesheet][:time_sheet_date])
    if !emp_data_in_table.empty?
      total_spent_time = emp_data_in_table.map(&:spend_of_time).sum
      spent_hours = total_spent_time.strftime("%H:%M")
      old_hour_spent = spent_hours.split(" ")     
    else
      no_hour_spent = ["00:00"]
    end
   
    emp_spent_hours = spent_time(new_spent_hours, old_hour_spent, no_hour_spent, emp_data_in_table)
  
    respond_to do |format|
     
      if emp_spent_hours <= "9.0" && @employee_timesheet.save
        format.html { redirect_to employee_timesheets_url, notice: "Employee timesheet was successfully created." }
        format.json { render :show, status: :ok, location: @employee_timesheet }
      else 
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_timesheet.errors, status: :unprocessable_entity }
      end
   end
     
  end

  def spent_time(new_spent_hours, old_hour_spent, no_hour_spent, employee)
     return spent_total_hours(new_spent_hours, old_hour_spent) if employee.present?
     new_data_update(new_spent_hours,no_hour_spent)
  end 

  # PATCH/PUT /employee_timesheets/1 or /employee_timesheets/1.json
  def update
    respond_to do |format|
      if @employee_timesheet.update(employee_timesheet_params)
        format.html { redirect_to @employee_timesheet, notice: "Employee timesheet was successfully updated." }
        format.json { render :show, status: :ok, location: @employee_timesheet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee_timesheet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_timesheets/1 or /employee_timesheets/1.json
  def destroy
    @employee_timesheet.destroy
    respond_to do |format|
      format.html { redirect_to employee_timesheets_url, notice: "Employee timesheet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_timesheet
      @employee_timesheet = EmployeeTimesheet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_timesheet_params
      # params.fetch(:employee_timesheet, {})
      params.require(:employee_timesheet).permit(:id, :user_id, :name, :title, :description, :project_name, :time_sheet_date, :spend_of_time, :time_from, :time_to, :office_total_hours)

    end
end
