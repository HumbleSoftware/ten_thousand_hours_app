class Reset
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :account_id, Integer
  property :password_key, String, :length => 32, :default => lambda { |r, p| SecureRandom.base64(24) }
  property :used, Boolean, :default => false
  property :created_at, DateTime
  property :updated_at, DateTime

  belongs_to :account

  validates_presence_of :account_id
  validates_presence_of :password_key
  validates_presence_of :used

  # callbacks
  before :save, :invalidate_old

  private
  def invalidate_old
    resets = Reset.all(:account_id => @account_id, :used => false)
    resets.update! :used => true
  end
end
