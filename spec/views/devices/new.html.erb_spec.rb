require 'rails_helper'

RSpec.describe "devices/new", type: :view do
  before(:each) do
    assign(:device, Device.new(
      :bluetooth_id => "MyString",
      :person => nil
    ))
  end

  it "renders new device form" do
    render

    assert_select "form[action=?][method=?]", devices_path, "post" do

      assert_select "input[name=?]", "device[bluetooth_id]"

      assert_select "input[name=?]", "device[user_id]"
    end
  end
end
