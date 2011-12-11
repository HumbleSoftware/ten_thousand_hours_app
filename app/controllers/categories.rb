TenThousandHoursApp.controllers :categories, :parent => :projects do

  get :index do
    @project = Project.get(params[:project_id])
    @categories = Category.all(:project_id => @project.id)
    render 'categories/index'
  end

  post :create do
  end

end
