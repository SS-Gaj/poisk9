require 'rails_helper'

RSpec.describe "bands/edit", type: :view do
  before(:each) do
    @band = assign(:band, Band.create!(
      :bn_head => "MyString",
      :bn_url => "MyString",
      :bn_anonce => "MyString",
      :bn_tema => "MyString",
      :bn_rang => 1,
      :bn_coment => "MyString"
    ))
  end

  it "renders the edit band form" do
    render

    assert_select "form[action=?][method=?]", band_path(@band), "post" do

      assert_select "input#band_bn_head[name=?]", "band[bn_head]"

      assert_select "input#band_bn_url[name=?]", "band[bn_url]"

      assert_select "input#band_bn_anonce[name=?]", "band[bn_anonce]"

      assert_select "input#band_bn_tema[name=?]", "band[bn_tema]"

      assert_select "input#band_bn_rang[name=?]", "band[bn_rang]"

      assert_select "input#band_bn_coment[name=?]", "band[bn_coment]"
    end
  end
end
