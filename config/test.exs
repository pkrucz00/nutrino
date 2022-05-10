import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :nutrino, NutrinoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "A9W4GIQlCP0wPLmKRUI+rMH0tUvrT/rTJqCAAb+a7tpN9VG9Gg51TswySqvbB4hZ",
  server: false

# In test we don't send emails.
config :nutrino, Nutrino.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
