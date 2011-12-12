TenThousandHoursApp.controllers :projects,
  :conditions => { :protect => true } do


  def self.protect(protected)
    condition do
      @error_message = 'You do not have access to this project.'
      halt 403, @error_message unless project_owned_by_current_user
    end if protected
  end

  get :index, :protect => false do
    @projects = Project.all( :account => current_account)
    render 'projects/index'
  end

  get :show, :with => :project_id do
    @project = Project.get(params[:project_id])
    total = Entry.all(:project_id => @project.id).sum(:time);
    @total = total ? total / 60 : 0
    render 'projects/show'
  end

  get :new, :protect => false do
    render 'projects/new'
  end

  post :create, :protect => false do
    @project = Project.new(params[:project])
    @project.account = current_account
    if @project.save
      redirect url(:projects, :index)
    else
      render 'projects/new'
    end
  end

end
