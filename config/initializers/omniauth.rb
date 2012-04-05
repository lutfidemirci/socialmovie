if Rails.env.production?
  FB_APP_ID = 'FB_APP_ID'
  FB_APP_SECRET = 'FB_APP_SECRET'
else
  FB_APP_ID = 'FB_APP_ID'
  FB_APP_SECRET = 'FB_APP_SECRET'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_APP_ID, FB_APP_SECRET, { :scope => 'email, offline_access, publish_actions' }
end