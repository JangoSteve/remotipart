# Overriding the redirect_to for Remotipart. Redirecting the received 'text/html' request to the 'js' format.
require 'uri'

module Remotipart
  module RedirectToOverrides
    include ERB::Util

    def self.included(base)
      base.class_eval do
        alias_method_chain :redirect_to, :remotipart
      end
    end

    def set_url_format(url, format = :js)
      uri, extn = URI.parse(url), '.' + format.to_s
      path_fragments = uri.path.split('/')
      last_fragment  = path_fragments.pop
      last_fragment.concat(extn) unless last_fragment.ends_with?(extn)
      uri.path = path_fragments.push(last_fragment).join('/')
      uri.to_s
    end

    def redirect_to_with_remotipart *args
      if remotipart_submitted?
        case redirect_path = args.shift
          when Hash
            redirect_path.merge!(format: :js)
          when String
            redirect_path = set_url_format(redirect_path, :js)
        end
        args.unshift(redirect_path)
      end

      redirect_to_without_remotipart *args
      response.body
    end
  end
end
