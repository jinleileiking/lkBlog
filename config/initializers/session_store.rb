# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lkBlog_session',
  :secret      => '03861cb8afb09e7c38d4f305433d4e01ece912ffbbb9424b73080563d1535376ed3ca7741e573fc8e4027575caa6ddc3e1f621775322d915fdfcc8d53499ce17'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
