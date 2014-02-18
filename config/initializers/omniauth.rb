OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '608873879182214', '2a7d62b84fd3febc1b3ba32a505e996e'
end