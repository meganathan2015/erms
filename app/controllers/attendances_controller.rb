class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    user_role = current_user.role 
    
    if user_role == "admin" || user_role == "manager"
       @attendances = Attendance.all
    elsif 
       @attendances = Attendance.all.where(user_id: current_user.id)
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
    start_date = params[:attendance][:start_date]
    end_date = params[:attendance][:end_date]
    count_no_of_days = (end_date.to_date..start_date.to_date).count

    @attendance = Attendance.new(attendance_params)
    @attendance.no_of_days = count_no_of_days
    @attendance.status = "pending"
    @attendance
      if @attendance.save
        redirect_to attendances_url
      else
        render :new
      end
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: "Attendance was successfully updated." }
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
    status = params[:rejected].present? ? params[:rejected] : "Approved"
    status = params[:cancel]
    if status == "Approved"
        if attendance.update_attributes(:status => status,
                                        :reason_for_rejection => "")
          flash[:notice] = "Leave Approved successfully"
          redirect_to leave_to_approve_attendances_url
        end
    elsif status == "Cancel"
      if attendance.update_attributes(:status => status,
                                   :reason_for_rejection => "")
          flash[:notice] = "Leave Cancel successfully"
          redirect_to leave_to_approve_attendances_url
      end
    else
      if attendance.update_attributes(:status => status,
                                      :reason_for_rejection => "Manager Rejected this leave")
        flash[:notice] = "Leave Rejected successfully"
        redirect_to leave_to_approve_attendances_url
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

      params.fetch(:attendance, {}).permit(:id, :user_id, :start_date, :end_date, :reason_for_leave, :manager_id, :reason_for_rejection)
    end
end
