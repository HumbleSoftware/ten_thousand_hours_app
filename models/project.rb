class Project
  include DataMapper::Resource

  belongs_to :account

  # property <name>, <type>
  property :id, Serial
  property :account_id, Integer
  property :title, String
  property :description, Text
  property :created_at, DateTime
  property :updated_at, DateTime
end
