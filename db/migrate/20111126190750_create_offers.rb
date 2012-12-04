class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :code
      t.string :description
      t.integer :zone_id
      t.integer :account_id

      t.timestamps
    end
  end
end
