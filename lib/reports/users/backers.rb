#encoding:utf-8
module Reports
  module Users
    class Backers
      class << self

        # report all_confirmed backings
        def all_confirmed_backers
          @backers = Backer.confirmed.includes(:project, :reward)

          @csv = CSV.generate(:col_sep => ',') do |csv_string|
            csv_string << [
              'Backing amount',
              'Counterpart min amount',
              'Backing date',
              'Project name',
              'Project successful',
              'Project end date',
              'Project category'
            ]

            @backers.each do |backer|
              csv_string << [
                backer.value,
                (backer.reward.minimum_value if backer.reward),
                (backer.created_at.strftime("%d/%m/%Y") if backer.created_at),
                backer.project.name,
                (backer.project.successful? ? 'Y' : 'N'),
                (backer.project.expires_at.strftime("%d/%m/%Y") if backer.project.expires_at),
                backer.project.category.name
              ]
            end
          end
        end

        # report most backed
        def most_backed(limit=50)
          @users = User.most_backeds.limit(limit)

          @csv = CSV.generate(:col_sep => ',') do |csv_string|

            # TODO: Change this later *order and names to use i18n*
            # for moment header only in portuguese.
            csv_string << [
              'User ID',
              'User name',
              'User Email',
              'Backing Nb',
              'Backing total amount'
            ]

            @users.each do |user|
              csv_string << [
                user.id,
                user.display_name,
                user.email,
                user.count_backs,
                user.display_total_of_backs
              ]
            end
          end
        end
      end
    end
  end
end
