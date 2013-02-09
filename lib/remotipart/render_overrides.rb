module Remotipart
  # Responder used to automagically wrap any non-xml replies in a text-area
  # as expected by iframe-transport.
  module RenderOverrides
    include ActionView::Helpers::TagHelper

    def self.included(base)
      base.class_eval do
        alias_method_chain :render, :remotipart
      end
    end

    def render_with_remotipart *args
      render_without_remotipart *args
      if remotipart_submitted?
        response.body = %{<textarea data-type=\"#{content_type}\" response-code=\"#{response.response_code}\">#{escape_once(response.body)}</textarea>}
        response.content_type = Mime::HTML
      end
      response_body
    end
  end
end
