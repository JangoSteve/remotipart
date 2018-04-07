# Configure Rails 3.0 to use form.js and remotipart
module Remotipart
  module Rails

    class Railtie < ::Rails::Railtie
      config.before_configuration do
        # Files to be added to :defaults
        FILES = ['jquery.iframe-transport', 'jquery.remotipart']

        # Figure out where rails.js (aka jquery_ujs.js if install by jquery-rails gem) is
        # in the :defaults array
        position = config.action_view.javascript_expansions[:defaults].index('rails') ||
          config.action_view.javascript_expansions[:defaults].index('jquery_ujs')

        # Merge form.js and then remotipart into :defaults array right after rails.js
        if position && position > 0
          config.action_view.javascript_expansions[:defaults].insert(position + 1, *FILES)
        # If rails.js couldn't be found, it may have a custom filename, or not be in the :defaults.
        # In that case, just try adding to the end of the :defaults array.
        else
          config.action_view.javascript_expansions[:defaults].push(*FILES)
        end
      end

      initializer "remotipart.view_helper" do
        ActionView::Base.send :include, RequestHelper
        ActionView::Base.send :include, ViewHelper
      end

      initializer "remotipart.controller_helper" do
        ActionController::Base.send :include, RequestHelper
        ActionController::Base.send :include, RenderOverrides
        ActionController::Base.send :include, RedirectToOverrides
      end

      initializer "remotipart.include_middelware" do
        config.app_middleware.insert_after ActionDispatch::ParamsParser, Middleware
      end
    end

  end
end
