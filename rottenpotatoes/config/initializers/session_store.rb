# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rottenpotatoes_session',
  :secret      => 'eb6739d63076aba0790710852948a1d078461d6b0af51a60a7dc31464fca3bfdcc352268989152bc0700bfeea34993f904bcbffce26457f8b1d71fc1b383621a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
