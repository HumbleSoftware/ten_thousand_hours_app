class Entry
  include DataMapper::Resource

  belongs_to :project

  # property <name>, <type>
  property :id, Serial
  property :category_id, Integer
  property :date, Date
  property :time, Time
  property :description, String
end
