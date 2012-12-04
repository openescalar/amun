class CreateDistros < ActiveRecord::Migration
  def change
    create_table :distros do |t|
      t.string :serial
      t.string :description
      t.string :arch
      t.string :url
      t.integer :zone_id
      t.integer :account_id

      t.timestamps
    end
  end
end
