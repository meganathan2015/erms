class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  enum role: { super_admin: 0, admin: 1, manager: 2, employee: 3 }

  has_many :employee_timesheets

  def set_fullname
    fullname = current_user.first_name current_user.last_name
  end
end
