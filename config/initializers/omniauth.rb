OmniAuth.config.logger = Rails.logger
if Rails.env.development? 
    fb_app_id = "608873879182214"
    fb_secret = '2a7d62b84fd3febc1b3ba32a505e996e'
else
    fb_app_id =  "1387251161495606" 
    fb_secret = "31e217dadb8ed0ea0c43aa09d07f63bf"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, fb_app_id , fb_secret 
end