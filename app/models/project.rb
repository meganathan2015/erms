class Project < ApplicationRecord
  validates_presence_of :project_name
  validates_presence_of :description
  validates_presence_of :reporting_manager
  validates_presence_of :status
  paginates_per 10

end
