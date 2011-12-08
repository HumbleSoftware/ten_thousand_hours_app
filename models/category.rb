class Category
  include DataMapper::Resource

  belongs_to :project

  # property <name>, <type>
  property :id, Serial
  property :category, String
end
