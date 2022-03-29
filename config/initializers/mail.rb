ActionMailer::Base.smtp_settings = {
  address: 'smtprelaypool.ispgateway.de',
  port: 587,
  domain: 'ist-ur.org',
  user_name: ENV['MAIL_USER'], # Rails.application.secrets.mail_user,
  password: ENV['MAIL_PW'], # Rails.application.secrets.mail_pw,
  authentication: :plain,
  enable_starttls_auto: true
}