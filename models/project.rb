class Project
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :title, String
  property :description, Text
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :account

  validates_presence_of :title
end
