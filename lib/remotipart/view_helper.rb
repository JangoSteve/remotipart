# frozen_string_literal: true

module Remotipart
  module ViewHelper

    def escape_javascript(javascript)
      if remotipart_submitted?
        super("#{javascript}")
      else
        super
      end
    end
    alias_method :j, :escape_javascript

    # No longer used
    # Retrained to prevent issues while updating
    def remotipart_response(_options = {}, &block)
      with_output_buffer(&block)
    end

  end
end
