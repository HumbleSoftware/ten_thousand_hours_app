TenThousandHoursApp.controllers :categories, :parent => :projects do

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
