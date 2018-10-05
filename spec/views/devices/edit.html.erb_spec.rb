require 'rails_helper'

RSpec.describe "devices/edit", type: :view do
  before(:each) do
    @device = assign(:device, Device.create!(
      :bluetooth_id => "MyString",
      :person => nil
    ))
  end

  it "renders the edit device form" do
    render

    assert_select "form[action=?][method=?]", device_path(@device), "post" do

      assert_select "input[name=?]", "device[bluetooth_id]"

      assert_select "input[name=?]", "device[user_id]"
    end
  end
end
