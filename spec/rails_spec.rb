require 'spec_helper'

describe "Remotipart Rails" do
  context "assigning the INSTALL PATH based on the rails verison" do
    before :each do
      if Rails::VERSION::MAJOR == 3 && Rails::VERSION::MINOR == 1
        @path = "app/assets/javascripts"
      else
        @path = "public/javascripts"
      end
    end

    it "should be correct" do
      ::Remotipart::Rails::INSTALL_PATH.should == @path
    end
  end
end
