class Reset
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :account_id, Integer
  property :password_key, String, :length => 32, :default => SecureRandom.base64(24)
  property :used, Boolean, :default => true
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :account
end
