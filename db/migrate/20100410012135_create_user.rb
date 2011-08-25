class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string   :name, :null => false, :default => ""
      t.string   :email
      t.boolean  :active, :default => true

      # Bushido auth fields
      t.bushido_authenticatable
      t.database_authenticatable
      t.integer  :facebook_uid
      t.string   :password
      t.string   :salt
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable

      t.timestamps
    end


    if on_bushido?
      add_index "users", "ido_id", :unique => true
    else
      case ActiveRecord::Base.connection.adapter_name
        when "MySQL"
          execute("ALTER TABLE users MODIFY COLUMN facebook_uid bigint NOT NULL");
        when "PostgreSQL"
          execute("ALTER TABLE users ALTER COLUMN facebook_uid TYPE bigint")
        else
          # raise "Don't know how to change column to bigint"
          puts "*#"*30
          puts "CAUTION: USING SQLITE. NOT CHANGING FACEBOOK_UID TO BIGINT"
          puts "*#"*30
      end

      add_index "users", "facebook_uid", :unique => true
    end

end

  def self.down
    drop_table :users
  end
end
