class RoleServer < ActiveRecord::Migration
  def up
    create_table :roles_servers, :id => false do |t|
        t.integer :role_id
        t.integer :server_id
        t.timestamps
    end
  end

  def down
    drop_table :roles_servers
  end
end
