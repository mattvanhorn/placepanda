require 'spec_helper'

describe "Pages Routing" do

  it "routes the home page correctly" do
    { :get => "/" }.should route_to(:controller => "pages", :action => "home")
  end

end
