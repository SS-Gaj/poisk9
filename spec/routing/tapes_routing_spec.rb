require "rails_helper"

RSpec.describe TapesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/tapes").to route_to("tapes#index")
    end

    it "routes to #new" do
      expect(:get => "/tapes/new").to route_to("tapes#new")
    end

    it "routes to #show" do
      expect(:get => "/tapes/1").to route_to("tapes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/tapes/1/edit").to route_to("tapes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/tapes").to route_to("tapes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tapes/1").to route_to("tapes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tapes/1").to route_to("tapes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tapes/1").to route_to("tapes#destroy", :id => "1")
    end

  end
end
