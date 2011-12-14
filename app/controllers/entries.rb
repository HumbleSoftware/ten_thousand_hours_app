TenThousandHoursApp.controllers :entries,
  :parent => :projects,
  :conditions => { :protect => true } do


  def self.protect(protected)
    condition do
      @error_message = 'You do not have access to entries for this project.'
      halt 403, @error_message unless project_owned_by_current_user
    end if protected
  end

  get :index, :provides => [:html, :json] do

    @project = Project.get(params[:project_id])
    @entries = Entry.all(:project_id => @project.id, :order => [:date.asc])
    @categories = Category.all(:project_id => @project.id)

    case content_type
      when :json then
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
      else
        render 'entries/index'
      end
  end

  post :create do

    @entry = Entry.new(params[:entry])
    @project = Project.get(params[:project_id])
    @entry.project = @project

    if params[:entry][:time].match(':')
      hours, minutes = params[:entry][:time].split(':')
      @entry.time = hours.to_i * 60 + minutes.to_i
    end

    if params[:entry][:category_id] == ''
      @entry.category_id = nil
    end

    if @entry.save
      redirect url_for(:projects, :show, @project.id)
    else
      render 'projects/show'
    end
  end

end
