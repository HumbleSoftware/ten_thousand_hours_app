class Category
  include DataMapper::Resource

  belongs_to :project

  validates_presence_of :category

  # property <name>, <type>
  property :id, Serial
  property :category, String
end
