module Remotipart
  # Responder used to automagically wrap any non-xml replies in a text-area
  # as expected by iframe-transport.
  module RenderOverrides
    include ActionView::Helpers::TagHelper

    def render *args
      super
      if remotipart_submitted?
        response.body = %{<textarea data-type=\"#{content_type}\" response-code=\"#{response.response_code}\">#{escape_once(response.body)}</textarea>}
        response.content_type = Mime::HTML
      end
      response_body
    end
  end
end
