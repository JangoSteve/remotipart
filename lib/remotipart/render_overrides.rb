module Remotipart
  # Responder used to automagically wrap any non-xml replies in a text-area
  # as expected by iframe-transport.
  module RenderOverrides
    include ERB::Util
  end
end
