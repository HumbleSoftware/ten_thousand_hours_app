migration 2, :create_projects do
  up do
    create_table :projects do
      column :id, Integer, :serial => true
      column :account_id, Integer
      column :title, String, :length => 255
      column :description, Text
    end
  end

  down do
    drop_table :projects
  end
end
