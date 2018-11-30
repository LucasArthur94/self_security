class AddUniquenessBluetoothIdToDevices < ActiveRecord::Migration[5.2]
  def change
    add_index :devices, :bluetooth_id, unique: true
  end
end
