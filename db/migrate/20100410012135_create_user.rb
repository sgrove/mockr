class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :name, :null => false, :default => ""
      t.boolean  :active, :default => true

      # Bushido auth fields
      t.bushido_authenticatable
      t.database_authenticatable
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable

      t.timestamps
    end


    if Devise::on_bushido?
      add_index "users", "ido_id", :unique => true
    end

end

  def self.down
    drop_table :users
  end
end
