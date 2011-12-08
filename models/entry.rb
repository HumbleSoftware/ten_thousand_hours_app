class Entry
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :project_id, Integer
  property :category_id, Integer
  property :date, Date
  property :time, Time
  property :description, String
end
