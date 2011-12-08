class Project
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :account_id, Integer
  property :title, String
  property :description, Text
end
