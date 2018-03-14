require 'rails_helper'

RSpec.describe "bands/index", type: :view do
  before(:each) do
    assign(:bands, [
      Band.create!(
        :bn_head => "Bn Head",
        :bn_url => "Bn Url",
        :bn_anonce => "Bn Anonce",
        :bn_tema => "Bn Tema",
        :bn_rang => 2,
        :bn_coment => "Bn Coment"
      ),
      Band.create!(
        :bn_head => "Bn Head",
        :bn_url => "Bn Url",
        :bn_anonce => "Bn Anonce",
        :bn_tema => "Bn Tema",
        :bn_rang => 2,
        :bn_coment => "Bn Coment"
      )
    ])
  end

  it "renders a list of bands" do
    render
    assert_select "tr>td", :text => "Bn Head".to_s, :count => 2
    assert_select "tr>td", :text => "Bn Url".to_s, :count => 2
    assert_select "tr>td", :text => "Bn Anonce".to_s, :count => 2
    assert_select "tr>td", :text => "Bn Tema".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Bn Coment".to_s, :count => 2
  end
end
