require 'rails_helper'

RSpec.describe "tapes/index", type: :view do
  before(:each) do
    assign(:tapes, [
      Tape.create!(
        :tp_site => 2,
        :tp_article => "Tp Article",
        :tp_url => "Tp Url",
        :tp_status => 3,
        :tp_tag => "Tp Tag",
        :tp_comments => "Tp Comments"
      ),
      Tape.create!(
        :tp_site => 2,
        :tp_article => "Tp Article",
        :tp_url => "Tp Url",
        :tp_status => 3,
        :tp_tag => "Tp Tag",
        :tp_comments => "Tp Comments"
      )
    ])
  end

  it "renders a list of tapes" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Tp Article".to_s, :count => 2
    assert_select "tr>td", :text => "Tp Url".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Tp Tag".to_s, :count => 2
    assert_select "tr>td", :text => "Tp Comments".to_s, :count => 2
  end
end
