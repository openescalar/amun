class CreateAzones < ActiveRecord::Migration
  def change
    create_table :azones do |t|
      t.string :name
      t.string :status
      t.string :endpoint
      t.integer :zone_id

      t.timestamps
    end
  end
end
