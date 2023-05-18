[
  import_deps: [:ecto, :phoenix, :surface],
  plugins: [Surface.Formatter.Plugin],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"]
]
