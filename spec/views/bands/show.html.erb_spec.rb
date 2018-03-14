require 'rails_helper'

RSpec.describe "bands/show", type: :view do
  before(:each) do
    @band = assign(:band, Band.create!(
      :bn_head => "Bn Head",
      :bn_url => "Bn Url",
      :bn_anonce => "Bn Anonce",
      :bn_tema => "Bn Tema",
      :bn_rang => 2,
      :bn_coment => "Bn Coment"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Bn Head/)
    expect(rendered).to match(/Bn Url/)
    expect(rendered).to match(/Bn Anonce/)
    expect(rendered).to match(/Bn Tema/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Bn Coment/)
  end
end
