require 'spec_helper'

describe Gem do
  it "collects 3rd party licenses" do
    licenses = Gem.licenses
    licenses.size.should == 2
    licenses[:Mit].size.should == 7
    licenses[:Unknown].size.should == 2
  end
end
