require 'spec_helper'

describe "Remotipart Rails" do
  context "assigning the INSTALL PATH based on the rails verison" do
    it "should be correct" do
      ::Remotipart::Rails::INSTALL_PATH.should == "public/javascripts"
    end
  end
end
