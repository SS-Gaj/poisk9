require 'rails_helper'

RSpec.describe "Tapes", type: :request do
  describe "GET /tapes" do
    it "works! (now write some real specs)" do
      get tapes_path
      expect(response).to have_http_status(200)
    end
  end
end
