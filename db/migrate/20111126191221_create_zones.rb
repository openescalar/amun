class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.string :description
      t.string :entrypoint
      t.string :apitype
      t.string :key
      t.string :secret
      t.string :tokenexp
      t.string :token
      t.string :tenant
      t.string :imported
      t.integer :account_id

      t.timestamps
    end
  end
end
