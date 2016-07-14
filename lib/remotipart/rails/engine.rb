# Configure Rails 3.1
module Remotipart
  module Rails

    class Engine < ::Rails::Engine
      initializer "remotipart.view_helper" do
        ActionView::Base.send :include, RequestHelper
        ActionView::Base.send :include, ViewHelper
      end

      initializer "remotipart.controller_helper" do
        ActionController::Base.send :include, RequestHelper
        ActionController::Base.send :include, RenderOverrides
      end

      initializer "remotipart.include_middelware" do
        if ::Rails.version < "5.0"
          puts "USING PARAMS PARSER"
          config.app_middleware.insert_after ActionDispatch::ParamsParser, Middleware
        else
          config.app_middleware.insert_after ActionDispatch::Flash, Middleware
        end
      end
    end

  end
end
