require 'rails_helper'

RSpec.describe "tapes/show", type: :view do
  before(:each) do
    @tape = assign(:tape, Tape.create!(
      :tp_site => 2,
      :tp_article => "Tp Article",
      :tp_url => "Tp Url",
      :tp_status => 3,
      :tp_tag => "Tp Tag",
      :tp_comments => "Tp Comments"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Tp Article/)
    expect(rendered).to match(/Tp Url/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Tp Tag/)
    expect(rendered).to match(/Tp Comments/)
  end
end
