begin
  if Rails.env.production?
    ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :enable_starttls_auto => true,
    :domain         => 'ride-lab.com'
    }
    ActionMailer::Base.delivery_method = :smtp
  end
rescue
  nil
end
