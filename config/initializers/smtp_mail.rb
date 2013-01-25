o = %w{ address port domain user_name password authentication enable_starttls_auto openssl_verify_mode}.inject({}) do |options,attr|
  v = "smtp_#{attr}"
  options[attr.to_sym] = APP_CONFIG[v] if APP_CONFIG[v].present?
  options
end

if o.present?
  ActionMailer::Base.smtp_settings = o
end