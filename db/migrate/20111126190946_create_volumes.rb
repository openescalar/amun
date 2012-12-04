class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.string :serial
      t.string :description
      t.string :status
      t.string :device
      t.string :name
      t.integer :size
      t.integer :zone_id
      t.integer :azone_id
      t.integer :server_id
      t.integer :infrastructure_id
      t.integer :account_id

      t.timestamps
    end
  end
end
