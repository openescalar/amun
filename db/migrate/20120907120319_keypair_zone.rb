class KeypairZone < ActiveRecord::Migration
  def up
    create_table :keypairs_zones, :id => false do |t|
        t.integer :keypair_id
        t.integer :zone_id
        t.timestamps
    end
  end

  def down
    drop_table :keypairs_zones
  end
end
