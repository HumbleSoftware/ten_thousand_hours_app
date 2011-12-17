migration 6, :create_resets do
  up do
    create_table :resets do
      column :id, Integer, :serial => true
      column :account_id, Integer
      column :password_key, String, :length => 32
      column :used, DataMapper::Property::Boolean
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end

  down do
    drop_table :resets
  end
end
