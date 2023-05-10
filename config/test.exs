import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :todo_htmx, TodoHtmxWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nmkO6L9EjctRZYrQ/XamyS/wa5KuCNZuu17Xqjc+/STToz755WxE2auBOw8NT/hN",
  server: false

# In test we don't send emails.
config :todo_htmx, TodoHtmx.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
