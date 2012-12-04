class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :protocol
      t.string :fromport
      t.string :toport
      t.string :source
      t.string :serial
      t.integer :firewall_id
      t.integer :infrastructure_id
      t.integer :account_id

      t.timestamps
    end
  end
end
