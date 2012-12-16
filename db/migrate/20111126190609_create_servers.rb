class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :serial
      t.string :fqdn
      t.string :name
      t.boolean :physical
      t.string :ip
      t.string :pip
      t.integer :status
      t.integer :zone_id
      t.integer :azone_id
      t.integer :offer_id
      t.integer :image_id
      t.integer :loadbalancer_id
      t.integer :firewall_id
      t.integer :keypair_id
      t.integer :account_id
      t.integer :infraescala_id
      t.integer :infrastructure_id


      t.timestamps
    end
  end
end
