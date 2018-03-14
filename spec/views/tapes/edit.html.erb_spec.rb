require 'rails_helper'

RSpec.describe "tapes/edit", type: :view do
  before(:each) do
    @tape = assign(:tape, Tape.create!(
      :tp_site => 1,
      :tp_article => "MyString",
      :tp_url => "MyString",
      :tp_status => 1,
      :tp_tag => "MyString",
      :tp_comments => "MyString"
    ))
  end

  it "renders the edit tape form" do
    render

    assert_select "form[action=?][method=?]", tape_path(@tape), "post" do

      assert_select "input#tape_tp_site[name=?]", "tape[tp_site]"

      assert_select "input#tape_tp_article[name=?]", "tape[tp_article]"

      assert_select "input#tape_tp_url[name=?]", "tape[tp_url]"

      assert_select "input#tape_tp_status[name=?]", "tape[tp_status]"

      assert_select "input#tape_tp_tag[name=?]", "tape[tp_tag]"

      assert_select "input#tape_tp_comments[name=?]", "tape[tp_comments]"
    end
  end
end
