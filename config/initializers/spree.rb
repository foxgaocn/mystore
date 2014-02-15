# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  # config.site_name = "Spree Demo Site"
  config.allow_ssl_in_production = false

  config.admin_interface_logo = "store/logo.gif"
  config.max_level_in_taxons_menu = 2
  config.logo = "store/logo.gif"
  
  # change for other shipping types
end

Spree.user_class = "Spree::User"

Spree::AusPostShipping::Config = Spree::AusPostShippingConfiguration.new 
Spree::AusPostShipping::Config[ :origin_postcode ] = '3179' 
Spree::AusPostShipping::Config[ :default_width ] = 10 
Spree::AusPostShipping::Config[ :default_height ] = 10
Spree::AusPostShipping::Config[ :default_length ] = 10
Spree::AusPostShipping::Config[ :default_weight ] = 0.2
Spree::AusPostShipping::Config[ :api_key ] = 'c1ded084-da0c-487c-8dec-b4634fe997c2'
Spree::AusPostShipping::Config[ :service_types ] = ['aus_parcel_regular'] 
Spree::AusPostShipping::Config[ :get_cheapest ] = true

config = Rails.application.config
config.spree.calculators.shipping_methods << Spree::Calculator::Shipping::AusPostShipping

