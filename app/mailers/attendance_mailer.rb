class AttendanceMailer < ApplicationMailer
    default from: "rbtech@gmail.com"
	def new_apply_leave_email(attendance)
    @attendance = attendance
    @url  = 'https://time.rayabharitech.com/attendances'
    @admin = User.find(1)
    user_email = User.find(attendance.user_id)
    mail(to: user_email.email, subject: "Leave Request Approval!")
  end
end
