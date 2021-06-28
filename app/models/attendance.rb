class Attendance < ApplicationRecord
    validates_presence_of :start_date
    validates_presence_of :end_date
    validates_presence_of :reason_for_leave
    paginates_per 10
end 
