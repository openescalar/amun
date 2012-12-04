class AccountUser < ActiveRecord::Migration
  def up
    create_table :accounts_users, :id => false do |t|
        t.integer :account_id
        t.integer :user_id
        t.timestamps
    end
  end

  def down
    drop_table :accounts_users
  end
end
