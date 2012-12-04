class DeploymentServer < ActiveRecord::Migration
  def up
    create_table :deployments_servers, :id => false do |t|
      t.integer :deployment_id
      t.integer :server_id
      t.timestamps
    end
  end

  def down
    drop_table :deployments_servers
  end
end
