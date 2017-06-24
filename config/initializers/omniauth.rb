OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '240386366459564', '00e43e372a067b135d8af8203bc9e926'
end