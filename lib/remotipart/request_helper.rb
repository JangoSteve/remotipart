# frozen_string_literal: true

module Remotipart
  module RequestHelper
    def remotipart_submitted?
      params[:remotipart_submitted] ? true : false
    rescue
      false
    end

    alias :remotipart_requested? :remotipart_submitted?
  end
end
