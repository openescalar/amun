class CreateFirewalls < ActiveRecord::Migration
  def change
    create_table :firewalls do |t|
      t.string :serial
      t.string :name
      t.string :description
      t.integer :zone_id
      t.integer :azone_id
      t.integer :infrastructure_id
      t.integer :account_id

      t.timestamps
    end
  end
end
