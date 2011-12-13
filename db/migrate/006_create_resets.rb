migration 6, :create_resets do
  up do
    create_table :resets do
      column :id, Integer, :serial => true
      column :account_id, Integer
      column :key, String, :length => 255
      column :used, Bool
      column :created_at, DateTime
      column :updated_at, DateTime
    end
  end

  down do
    drop_table :resets
  end
end
