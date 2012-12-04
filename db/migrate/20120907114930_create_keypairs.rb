class CreateKeypairs < ActiveRecord::Migration
  def change
    create_table :keypairs do |t|
      t.string :name
      t.text :public
      t.text :private
      t.string :fingerprint
      t.integer :zone_id
      t.integer :azone_id
      t.integer :infrastructure_id
      t.integer :account_id

      t.timestamps
    end
  end
end
