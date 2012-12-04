class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :serial
      t.string :description
      t.string :arch
      t.integer :zone_id
      t.integer :azone_id
      t.integer :account_id

      t.timestamps
    end
  end
end
