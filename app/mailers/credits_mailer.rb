class CreditsMailer < ActionMailer::Base
  include ERB::Util
  default :from => "#{t('site.name')} <#{t('site.email.system')}>"

  def request_refund_from(backer)
    @backer = backer
    @user = backer.user
    mail(:to => t('site.email.payments'), :subject => I18n.t('credits_mailer.request_refund_from.subject', :name => @user.name))
  end
end
