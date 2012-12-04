class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :serial
      t.string :name
      t.string :description
      t.text   :metadata
      t.integer :deployment_id
      t.integer :account_id

      t.timestamps
    end
  end
end
