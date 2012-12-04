class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :serial
      t.string :name
      t.string :description
      t.text   :metadata
      t.integer :account_id

      t.timestamps
    end
  end
end
