class UserManagementsController < ApplicationController
  before_action :set_user_management, only: %i[ show edit update destroy new_user_mgmnt edit_user update_user active_user_update]

  # GET /user_managements or /user_managements.json
  def index
    # @users = User.order(:name).page params[:page]
    @user_managements = UserManagement.order(:first_name).page params[:page]
    # @user_managements = UserManagement.all
    @user_mgmt = UserManagement.where(id: params[:id])
  end


  def user_list
    @user_managements = UserManagement.find(params[:id])
  end
 
  def active_user_update
    user_management = UserManagement.find(params[:id])
    respond_to do |format|
      if user_management
        user_management.update_attribute(:status, "Active")
        format.html { redirect_to user_managements_url, notice: "User management was successfully Activated." }
        format.json { head :no_content }

      end
    end
  end

  def edit_photo_user
    @user_photo_changes = UserManagement.find(params[:id])
  end


  def edit_user
    @user_mgments = UserManagement.find(params[:id])
  end

  def update_user
    @user_management = UserManagement.find(params[:user_management][:id])
    user = User.find_by_email(params[:user_management][:email])
    role_data = params[:user_management][:role].to_i
  
    respond_to do |format|
        if @user_management
            @user_management.update_attributes(emp_code: params[:user_management][:emp_code], 
                                                first_name: params[:user_management][:first_name],
                                                last_name: params[:user_management][:last_name],
                                                mother_name: params[:user_management][:mother_name],
                                                role: params[:user_management][:role], 
                                                gender: params[:user_management][:gender], 
                                                bg_group: params[:user_management][:bg_group],
                                                dob: params[:user_management][:dob],
                                                doj: params[:user_management][:doj],
                                                status: params[:user_management][:status],
                                                email: params[:user_management][:email], 
                                                phone: params[:user_management][:phone], 
                                                pan_details: params[:user_management][:pan_details], 
                                                aadhar_details: params[:user_management][:aadhar_details], 
                                                address: params[:user_management][:address]) && user.update_attribute(:role, role_data)



          format.html { redirect_to user_managements_url, notice: "User Profile was successfully updated." }
          format.json { render :show, status: :created, location: @user_management }
          render layout: false
        else
          format.html { render :edit_user, status: :unprocessable_entity }
          format.json { render json: @user_management.errors, status: :unprocessable_entity }
        end
    end
  end


  def delete_user
    user_mgmnt = UserManagement.find(params[:id])
    respond_to do |format|
      if user_mgmnt
        user_mgmnt.update_attribute(:profile_pictures, "" )
        format.html { redirect_to user_managements_url, notice: "User management was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end 

  def upload_profile_image
    user_management_image = UserManagement.find(params[:user_management][:id])
    
    respond_to do |format|
      if user_management_image
        user_management_image.update_attribute(:profile_pictures, params[:user_management][:profile_pictures])
        format.html { redirect_to user_managements_url, notice: "User management was successfully created." }
        format.json { render :show, status: :created, location: @user_management_image }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_management_image.errors, status: :unprocessable_entity }
      end
    end
  end
  # GET /user_managements/1 or /user_managements/1.json
  def show
  end

  # GET /user_managements/new
  def new
    @user_management = UserManagement.new
  end

  # GET /user_managements/1/edit
  def edit
  end

  # POST /user_managements or /user_managements.json
  def create
    email_provider = params[:user_management][:email_provider]
    user_status = "Active"
    email_symbol = "@"
    role_data = params[:user_management][:role].to_i
    @email = params[:user_management][:email] + email_symbol + email_provider
    @user_management = UserManagement.new(user_management_params)
    @user_management.status = user_status
    @user_management.email = @email
    @user_management
    @user = User.new
    respond_to do |format|
      if @user_management.save && User.create(first_name: params[:user_management][:first_name], last_name: params[:user_management][:last_name], role: role_data, email: @email, password: params[:user_management][:password], password_confirmation: params[:user_management][:password_confirmation])
        format.html { redirect_to user_managements_url, notice: "User management was successfully created." }
        format.json { render :show, status: :created, location: @user_management }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_management.errors, status: :unprocessable_entity }
      end
    end
  end

  def new_user_mgmnt
  end

  def add_data_user_mgmnt
  end

  def edit_password_user
    @user_password = UserManagement.find(params[:id])
  end

  def change_password_user
    @user_management_change_password = UserManagement.find(params[:id])
    user_change_passwd = User.find_by_email(params[:user_management][:email])
    
    respond_to do |format|
      if @user_management_change_password && user_change_passwd
        @user_management_change_password.update_attributes(password: params[:user_management][:password],
                                                          password_confirmation: params[:user_management][:password_confirmation])
        user_change_passwd.update_attributes(password: params[:user_management][:password],
                                             password_confirmation: params[:user_management][:password_confirmation])
        
          
        format.html { redirect_to authenticated_root_url, notice: "Password was successfully updated ." }
        format.json { render :show, status: :created, location: @user_management_change_password }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_management_change_password.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_managements/1 or /user_managements/1.json
  def update
    respond_to do |format|
      if @user_management.update(user_management_params)
        format.html { redirect_to @user_management, notice: "User management was successfully updated." }
        format.json { render :show, status: :ok, location: @user_management }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_managements/1 or /user_managements/1.json
  def destroy
    @user_management.update_attribute(:status, "Inactive")
    respond_to do |format|
      format.html { redirect_to user_managements_url, notice: "User management was successfully Inactivated." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_management
      @user_management = UserManagement.find(params[:id]) 
    end

    # Only allow a list of trusted parameters through.
    def user_management_params
      params.fetch(:user_management, {}).permit(:id, :first_name, :last_name, :role, :password, :password_confirmation, :status)
    end
end
