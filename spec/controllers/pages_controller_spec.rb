require 'spec_helper'

describe PagesController do
  describe "home" do
    it "renders the home view" do
      get :home
      response.should render_template :home
    end
  end
end
