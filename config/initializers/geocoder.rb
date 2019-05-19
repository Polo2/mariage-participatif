Geocoder.configure(
  lookup: :google,
  use_https: true,
  api_key: ENV["GOOGLE_API_KEY_BACKEND"],
  units: :km,
)
