module Remotipart
  module Rails
    if ::Rails.version < "3.1"
      require 'remotipart/rails/railtie'
      INSTALL_PATH = "public/javascripts"
    else
      require 'remotipart/rails/engine'
      INSTALL_PATH = "app/assets/javascripts"
    end
    require 'remotipart/rails/version'
  end
end
