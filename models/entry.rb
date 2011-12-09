class Entry
  include DataMapper::Resource

  belongs_to :project

  validates_presence_of :date
  validates_presence_of :time

  # property <name>, <type>
  property :id, Serial
  property :category_id, Integer
  property :date, Date
  property :time, Integer
  property :description, String
end
