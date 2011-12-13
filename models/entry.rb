class Entry
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :category_id, Integer
  property :date, DateTime
  property :time, Integer
  property :description, String

  #parents
  belongs_to :project
  belongs_to :category

  #validations
  validates_presence_of :date
  validates_primitive_type_of :date,
    :message => 'Invalid format.'

  validates_presence_of :time
  validates_primitive_type_of :time,
    :message => 'Invalid format.'

  validates_with_block :category_id do
    if @category_id
      category = Category.get(@category_id)
      if !category || category.project_id != @project_id
        [false, 'invalid category']
      end
    end
    true
  end
end
