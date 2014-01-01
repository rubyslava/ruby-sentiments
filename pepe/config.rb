######################################################################
# General settings.
######################################################################

# Asset locations
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

# Slim's default format is xhtml. Why oh why?
Slim::Engine.default_options[:format] = :html5

######################################################################
# Development environment.
######################################################################

configure :development do
  Slim::Engine.default_options[:pretty] = true
  activate :livereload
end


######################################################################
# Build environment.
######################################################################

configure :build do
  activate :relative_assets
  activate :directory_indexes
  activate :asset_hash

  # Ensmallen assets
  activate :minify_css
  activate :minify_javascript
  activate :image_optim
  activate :gzip
  #
  # Change to your Google Analytics key (e.g. UA-XXXXX-Y)
  # To disable GA, leave unset or set to nil
  set :ga_key, nil
end
