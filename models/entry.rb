class Entry
  include DataMapper::Resource

  belongs_to :project

  validates_presence_of :date
  validates_primitive_type_of :date,
    :message => 'Invalid format.'
  validates_presence_of :time
  validates_primitive_type_of :time,
    :message => 'Invalid format.'

  # property <name>, <type>
  property :id, Serial
  property :category_id, Integer
  property :date, Date
  property :time, Integer
  property :description, String
end
