class CreateLoadbalancers < ActiveRecord::Migration
  def change
    create_table :loadbalancers do |t|
      t.string :serial
      t.string :description
      t.integer :port
      t.integer :serverport
      t.string  :subzone
      t.string  :protocol
      t.integer :zone_id
      t.integer :azone_id
      t.integer :account_id

      t.timestamps
    end
  end
end
