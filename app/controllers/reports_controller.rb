class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]

  # GET /reports or /reports.json
  def index
    # @reports = Report.all
    @employee_times = EmployeeTimesheet.all
    @attendances = Attendance.all
    @projects = Project.all

   month_start = Time.now.at_beginning_of_month
   begin_start_month = month_start.strftime("%Y-%m-%d")
   month_end = Time.now.at_end_of_month
   end_of_month = month_end.strftime("%Y-%m-%d")
   @user_single_chart = EmployeeTimesheet.select("user_id,project_name,time_sheet_date,sum(spend_of_time)").where("time_sheet_date between ? and  ?",begin_start_month, end_of_month).group(:project_name,:time_sheet_date,:user_id).sum(:spend_of_time)
   @all_user_chart = EmployeeTimesheet.select("project_name,time_sheet_date,sum(spend_of_time)").where("user_id=?",current_user.id).group(:project_name,:time_sheet_date).sum(:spend_of_time)
  
   @attendance_single_chart = Attendance.select("status,start_date,sum(no_of_days)").where("start_date between ? and  ?",begin_start_month, end_of_month).group(:status,:start_date).sum(:no_of_days)
end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    # @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    # @report = Report.new(report_params)

    # respond_to do |format|
    #   if @report.save
    #     format.html { redirect_to @report, notice: "Report was successfully created." }
    #     format.json { render :show, status: :created, location: @report }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @report.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    # respond_to do |format|
    #   if @report.update(report_params)
    #     format.html { redirect_to @report, notice: "Report was successfully updated." }
    #     format.json { render :show, status: :ok, location: @report }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @report.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    # @report.destroy
    # respond_to do |format|
    #   format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      # @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      # params.fetch(:report, {})
    end
end
