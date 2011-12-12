TenThousandHoursApp.controllers :categories,
  :parent => :projects,
  :conditions => { :protect => true } do


  def self.protect(protected)
    condition do
      @project = Project.get(params[:project_id])
      @error_message = 'You do not have access to categories for this project.'
      halt 403, @error_message unless @project.account == current_account
    end if protected
  end

  get :index do
    @project = Project.get(params[:project_id])
    @categories = Category.all(:project_id => @project.id)
    render 'categories/index'
  end

  post :create do
    @project = Project.get(params[:project_id])
    @category = Category.new(params[:category])
    @category.project = @project

    if @category.save
      redirect url(:categories, :index, :project_id => @project.id)
    else
      render 'categories/new'
    end
  end

end
