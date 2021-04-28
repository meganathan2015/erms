class EmployeeTimesheetsController < ApplicationController
  before_action :set_employee_timesheet, only: %i[ show edit update destroy ]

  # GET /employee_timesheets or /employee_timesheets.json
  def index
    # @employee_timesheets = EmployeeTimesheet.all
    @employee_timesheets = EmployeeTimesheet.all.where(user_id: current_user.id)
  end

  # GET /employee_timesheets/1 or /employee_timesheets/1.json
  def show
  end

  # GET /employee_timesheets/new
  def new
    @employee_timesheet = EmployeeTimesheet.new
  end

  # GET /employee_timesheets/1/edit
  def edit
  end

  # POST /employee_timesheets or /employee_timesheets.json
  def create
    @employee_timesheet = EmployeeTimesheet.new(employee_timesheet_params)

    respond_to do |format|
      if @employee_timesheet.save
        format.html { redirect_to employee_timesheets_url, notice: "Employee timesheet was successfully created." }
        format.json { render :show, status: :created, location: @employee_timesheet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee_timesheet.errors, status: :unprocessable_entity }
      end
    end
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
      params.require(:employee_timesheet).permit(:id, :user_id, :name, :title, :description, :project_name, :time_sheet_date, :spend_of_time, :time_from, :time_to, :break_from, :break_to, :total_break_time, :office_total_hours, :status)

    end
end
