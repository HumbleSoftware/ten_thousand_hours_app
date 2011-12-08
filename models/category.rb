class Category
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :project_id, Integer
  property :category, String
end
