class Reset
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :account_id, Integer
  property :key, String
  property :used, Bool
  property :created_at, DateTime
  property :updated_at, DateTime
end
