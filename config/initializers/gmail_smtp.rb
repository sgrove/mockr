ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => ENV['SMTP_TLS'],
  :address              => ENV['SMTP_SERVER'],
  :port                 => ENV['SMTP_PORT'],
  :authentication       => ENV['SMTP_AUTHENTICATION'],
  :user_name            => ENV['SMTP_USER'],
  :password             => ENV['SMTP_PASSWORD']
}
