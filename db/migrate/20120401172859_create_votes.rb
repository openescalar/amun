class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :serial
      t.integer :infraescala_id

      t.timestamps
    end
  end
end
