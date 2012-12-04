class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :key
      t.string :secret
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
