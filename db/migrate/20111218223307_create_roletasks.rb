class CreateRoletasks < ActiveRecord::Migration
  def change
    create_table :roletasks do |t|
      t.string :serial
      t.string :name
      t.text :content
      t.text :metadata
      t.integer :account_id
      t.integer :role_id

      t.timestamps
    end
  end
end
