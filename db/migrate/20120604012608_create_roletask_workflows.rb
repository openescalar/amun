class CreateRoletaskWorkflows < ActiveRecord::Migration
  def change
    create_table :roletask_workflows do |t|
      t.integer :roletask_id
      t.integer :workflow_id

      t.timestamps
    end
  end
end
