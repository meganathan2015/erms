class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    # user_role = current_user.role 
    if params[:user_id]
      user_role = User.find(params[:user_id])
    else
      user_role = User.find(current_user.id)
    end
    if user_role.role == "admin" || user_role.role == "manager"
      # @user_managements = UserManagement.order(:first_name).page params[:page]
      @attendances = Attendance.order("start_date desc").page params[:page]
    elsif 
      @page = 10
      @offset = 0
      @attendances = Attendance.where(user_id: current_user.id).order(start_date: :desc).page params[:page]
      # @attendances = Attendance.all.where(user_id: current_user.id).order(start_date: :desc)
    end   
  end

  # GET /attendances/1 or /attendances/1.json
  def show
    
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances or /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)
    @attendance.status = "pending"
    @attendance
    respond_to do |format|
      if @attendance.save
        AttendanceMailer.new_apply_leave_email(@attendance).deliver

        format.html { redirect_to attendances_url, notice: "Attendance was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to attendances_url, notice: "Attendance was successfully updated." }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: "Attendance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def leave_to_approve
    user_role = current_user.role 
    
    if user_role == "admin" || user_role == "manager"
       @attendances = Attendance.all
    elsif 
       @attendances = Attendance.all.where(user_id: current_user.id)
    end   
  end

  def approve_to_leave
    attendance = Attendance.find(params[:id])
    status = params[:rejected]
    case status
     
    when "Approved"
      if attendance.update_attributes(:status => status,
        :reason_for_rejection => params[:message])

      render json: {:success => true}
      AttendanceMailer.new_apply_leave_email(attendance).deliver

      else
      render json: {:success => false}
      # redirect_to leave_to_approve_attendances_url
      end
    when "Cancelled"
      if attendance.update_attributes(:status => status,
        :reason_for_rejection => params[:message])
 
      render json: {:success => true}
      AttendanceMailer.new_apply_leave_email(attendance).deliver

      else
      render json: {:success => false}
      # redirect
    end
  else 
      if attendance.update_attributes(:status => status,
        :reason_for_rejection => params[:message])
      render json: {:success => true}
      AttendanceMailer.new_apply_leave_email(attendance).deliver
      else
      render json: {:success => false}
      # redirect_to leave_to_approve_attendances_url
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attendance_params
      # params.require(:attendance).permit(:id, :user_id, :start_date, :end_date, :no_of_days, :reason_for_leave, :manager_id, :status, :reason_for_rejection)

      params.fetch(:attendance, {}).permit(:id, :user_id, :start_date, :end_date, :no_of_days, :reason_for_leave, :manager_id, :reason_for_rejection)
    end
end
