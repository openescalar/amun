class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :status
      t.integer :account_id
      t.integer :server_id
      t.string :user
      t.string :ident
      t.string :description
      t.text :child
      t.text :output

      t.timestamps
    end
  end
end
