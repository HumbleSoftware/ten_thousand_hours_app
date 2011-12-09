migration 5, :alter_time_for_entry do
  up do
    modify_table :entries do
      change_column :time, Integer
    end
  end

  down do
  end
end
