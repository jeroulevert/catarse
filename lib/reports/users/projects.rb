#encoding:utf-8
module Reports
  module Users
    class Projects
      class << self

        # report all project owners
        def all_project_owners
          @collection = User.joins(:projects).where('projects.visible is true').includes(:projects)

          @csv = CSV.generate(:col_sep => ',') do |csv_string|
            csv_string << [
              'Project ID',
              'Project name',
              'Project sucessful',
              'Owner name',
              'Owner email',
              'Owner state',
              'Owner address',
              'Owner phone nb'
            ]

            @collection.each do |resource|
              resource.projects.each do |project|
                csv_string << [
                  project.id,
                  project.name,
                  (project.successful? ? 'Y' : 'N'),
                  resource.name,
                  resource.email,
                  resource.address_state,
                  resource.address_city,
                  resource.phone_number
                ]
              end
            end
          end
        end
      end
    end
  end
end
