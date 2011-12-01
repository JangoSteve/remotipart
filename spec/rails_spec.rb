require 'spec_helper'

describe "Remotipart Rails" do
  context "assigning the INSTALL PATH based on the rails verison:" do
    before :each do
      module Rails
      end
    end

    it "3.0 should be correct" do
      Object.const_set(:Rails, stub('Rails', :version => "3.0"))
      debugger
      puts ::Remotipart::Rails::INSTALL_PATH
    end

    it "3.1 should be correct" do
      Object.const_set(:Rails, stub('Rails', :version => "3.1"))
      puts ::Remotipart::Rails::INSTALL_PATH
    end
  end
end
