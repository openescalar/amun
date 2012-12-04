class CreateInfrastructures < ActiveRecord::Migration
  def change
    create_table :infrastructures do |t|
      t.string :serial
      t.string :name
      t.string :description
      t.text :definition
      t.integer :account_id

      t.timestamps
    end
  end
end
