class CreateDeployments < ActiveRecord::Migration
  def change
    create_table :deployments do |t|
      t.string :serial
      t.string :name
      t.string :description
      t.text   :definition
      t.text   :metadata
      t.integer :account_id

      t.timestamps
    end
  end
end
