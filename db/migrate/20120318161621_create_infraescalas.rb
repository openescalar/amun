class CreateInfraescalas < ActiveRecord::Migration
  def change
    create_table :infraescalas do |t|
      t.string  :itype   # server firewall loadbalancer volume
      t.string  :imodel    # DSL properties like offer, image, amount
      t.integer :iactive  # number of active objects (3 volumes, 2 instances running)
      t.integer :imax  # max number to scale objects
      t.integer :ivote # number of actual votes
      t.integer :iorig # initial of original instances
      t.integer :iescalar # min number of votes required to scale
      t.integer :infrastructure_id

      t.timestamps
    end
  end
end
