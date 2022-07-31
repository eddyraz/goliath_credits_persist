import Config

config :goliath_credits_persistence, Goliath.Credits.Persistence.Repo,
  database: "goliath_credits_persistence_repo",
  username: "goliath_master",
  password: "Zion2190**",
  hostname: "localhost"


config :goliath_credits_persistence, ecto_repos: [Goliath.Credits.Persistence.Repo]
