class Timesheet
    class Processor
        def initialize(employee_timesheet_params={})
            @params = employee_timesheet_params
            self.attributes = {}
            employee_timesheet_params.each do |key, value|
                public_send("#{key}=", value)
                attributes[key] = value
            end
        end

        def employee
            @employee ||= EmployeeTimesheet.find_by_user_id(@params[:employee_timesheet][:user_id])
        end

        def timesheets 
            @timesheets ||= EmployeeTimesheet.where(user_id: @params[:employee_timesheet][:user_id],time_sheet_date: params[:employee_timesheet][:time_sheet_date])
        end

        def spent_time
            return 0 if timesheets.blank? 
            total_spent_time = emp_time.map(&:spend_of_time).sum
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
    end
end



employee_timesheet"=><ActionController::Parameters 
{"user_id"=>"7", "description"=>"Test ", "project_name"=>"Housing Project", 
"time_sheet_date"=>"2021-06-04", "start_time"=>"13:20", "end_time"=>"18:10", 
"spend_of_time"=>"4:50"} permitted: false>, 

"commit"=>"Create Timesheet", "controller"=>"employee_timesheets", "action"=>"create"} 
permitted: false>):
