TenThousandHoursApp.controllers :entries,
  :parent => :projects,
  :conditions => { :protect => true } do


  def self.protect(protected)
    condition do
      @error_message = 'You do not have access to entries for this project.'
      halt 403, @error_message unless project_owned_by_current_user
    end if protected
  end

  get :index do
    @project = Project.get(params[:project_id])
    @entries = Entry.all(:project_id => @project.id, :order => [:date.asc])
    render 'entries/index'
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
