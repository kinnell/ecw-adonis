# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

if Rails.env.production? && ENV['SECRET_TOKEN'].blank?
	raise 'SECRET_TOKEN environment variable must be set!'
end

Adonis::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || '26ed2e0cdf0767c5592e0eba7bda6cdc6937b7c5ec5613f880ca35addf32f5282dcc8fc5ce6d6dd673455f03b4313ac6ee6df499af2f2250a8b509e3ef4f04b5'
