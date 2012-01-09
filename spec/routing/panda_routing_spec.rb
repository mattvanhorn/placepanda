require 'spec_helper'

describe "Pandda Routing" do

  it "routes the color img requests correctly" do
    { :get => "/1616/1000" }.should route_to(:controller => "pandas", :action => "color", :width => '1616', :height => '1000')
  end
  it "routes the grayscale img requests correctly" do
    { :get => "g/1616/1000" }.should route_to(:controller => "pandas", :action => "grayscale", :width => '1616', :height => '1000')
  end

end
