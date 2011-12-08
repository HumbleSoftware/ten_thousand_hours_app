TenThousandHoursApp.controllers :projects do

  get :index do
    @projects = Project.all( :account => current_account)
    render 'projects/index'
  end

  get :show, :with => :id do
    @project = Project.get(params[:id])
    render 'projects/show'
  end

  get :new do
    render 'projects/new'
  end

  post :create do
    @project = Project.new(params[:project])
    @project.account = current_account
    if @project.save
      redirect url(:projects, :index)
    else
      render 'projects/new'
    end
  end

end
