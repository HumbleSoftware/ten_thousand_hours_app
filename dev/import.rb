require 'date'
require 'json'
require 'rubygems'
require 'data_mapper'
require '../models/project.rb'
require '../models/entry.rb'
require '../models/category.rb'

# config
project_id = 10

# prep work
puts 'Connecting to database...'
DataMapper.setup(:default, 'mysql://root:amalla@localhost/ten_thousand_hours_app')

puts 'Getting data from file...'
test_data = IO.read('test_data.json')

puts 'Parsing json...'
data = JSON.parse(test_data)

# methods
def get_time(value)
  Float(value) * 60
end

def get_date(value)
  month, day, year = value.split('/')
  Date.new(Integer(year), Integer(month), Integer(day))
end

# importing
puts 'Importing data...'
project = Project.get(project_id)
dates = data['dates']
descriptions = data['descriptions']
data['practices'].each do |category_data|

  # category
  category_label = category_data['label']
  puts "\t" + "Importing category '" + category_label + "'..."
  category = Category.new
  category.project = project
  category.category = category_label
  category.save

  # entries
  entries = category_data['data']
  entries.each do |entry_data|
    date = get_date(dates[entry_data[0]])
    time = get_time(entry_data[1])
    description = descriptions[entry_data[0]]
    if (time > 0)
      entry = Entry.new
      entry.date = date
      entry.time = time
      entry.project = project
      entry.description = description
      entry.category_id = category.id
      if (!entry.valid?)
        puts 'invalid'
        puts entry.inspect
      end
      puts entry.inspect
      entry.save
    end
  end
end
puts 'Done.'
