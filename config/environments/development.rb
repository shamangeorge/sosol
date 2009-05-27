# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
#config.action_mailer.raise_delivery_errors = false


#for mail testing
#require 'smtp_tls'
config.action_mailer.raise_delivery_errors = true
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = 
#config.action_mailer.server_settings = 
#ActionMailer::Base.smtp_settings =
{
	:address			=>	'smtp.gmail.com',
	:port					=>	587,
	:domain				=>	"www.mybit.net",
	:authentication	=>	:plain,
	:user_name			=>	'sosol.site@gmail.com',
	:password				=>	'protosite'
}



# config/environments/development_secret.rb should set
# RPX_API_KEY and RPX_REALM (site name) for RPX,
# and possibly other unversioned secrets for development
require File.join(File.dirname(__FILE__), 'development_secret')
