TenThousandHoursApp.controllers :vis do

  layout :vis

  get :index, :with => :project_id do
    @project = Project.get(params[:project_id])
    render 'vis/vis'
  end

  get :data, :with => :project_id, :provides => [:json] do

    @project = Project.get(params[:project_id])
    @entries = Entry.all(:project_id => @project.id, :order => [:date.asc])
    @categories = Category.all(:project_id => @project.id)

    json = {
      start_date: @entries.first.date,
      totals: [],
      dates: [],
      descriptions: [],
      entries: []
    }

    category_map = {}
    @categories.each do |c|
      json[:entries].push label: c.category, data: []
      category_map[c.id] = category_map.length
    end

    count = 0
    total = 0
    current_date = @entries.first.date
    json[:dates][count] = current_date
    @entries.each do |entry|
      if current_date != entry.date
        current_date = entry.date
        json[:totals].push [count, total]
        json[:dates][count] = current_date.strftime('%m/%d/%Y')
        count += 1
      end
      entries_data = json[:entries][category_map[entry.category_id]][:data]
      json[:descriptions][entries_data.length] = entry.description
      entries_data.push [count, entry.time]
      total += entry.time
    end
    json[:totals].push [count, total]

    json.to_json
  end
end
