module Remotipart

  # A middleware to look for our form parameters and
  # encourage Rails to respond with the requested format
  class Middleware
    def initialize app
      @app = app
    end

    def call env
      # For some reason, in Rails 3.0, `env['rack.request.form_hash']`
      # isn't populated unless we manually initialize a new Rack::Request
      # and call the `POST` method on it
      if ::Rails.version < "3.1"
        Rack::Request.new(env).POST
      end
      params = env['rack.request.form_hash']

      if params
        if params['X-Requested-With'] == 'IFrame' || env['HTTP_X_REQUESTED_WITH'] == 'FormData'
          params['remotipart_submitted'] = params['X-Requested-With'] || env['HTTP_X_REQUESTED_WITH']
          # This was using a custom transport, and is therefore an XHR
          # This is required if we're going to override the http_accept
          env['HTTP_X_REQUESTED_WITH'] = 'xmlhttprequest'
        end
        # For iFrame transport, override the accepted format, because it isn't what we really want
        env['HTTP_ACCEPT'] = params['X-Http-Accept'] if params['X-Http-Accept']
      end

      @app.call(env)
    end
  end
end
