class CreateVpns < ActiveRecord::Migration
  def change
    create_table :vpns do |t|
      t.string :serial
      t.string :description
      t.string :network
      t.string :netmask
      t.integer :client

      t.timestamps
    end
  end
end
