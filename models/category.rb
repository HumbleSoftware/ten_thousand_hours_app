class Category
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :category, String

  belongs_to :project

  validates_presence_of :category
  validates_uniqueness_of :category
end
