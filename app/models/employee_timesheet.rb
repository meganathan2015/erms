class EmployeeTimesheet < ApplicationRecord
    belongs_to :user
    validates_presence_of :description
    validates_presence_of :project_name
    validates_presence_of :time_sheet_date
    validates_presence_of :spend_of_time
    validates_presence_of :time_from
    validates_presence_of :time_to
    paginates_per 10

end
