class Project
  include DataMapper::Resource

  belongs_to :account

  validates_presence_of :title

  # property <name>, <type>
  property :id, Serial
  property :title, String
  property :description, Text
  property :created_at, DateTime
  property :updated_at, DateTime
end
