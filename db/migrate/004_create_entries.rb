migration 4, :create_entries do
  up do
    create_table :entries do
      column :id, Integer, :serial => true
      column :project_id, Integer
      column :category_id, Integer
      column :date, Date
      column :time, Time
      column :description, String, :length => 255
    end
  end

  down do
    drop_table :entries
  end
end
