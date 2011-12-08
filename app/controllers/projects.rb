TenThousandHoursApp.controllers :projects do

  get :index do
    render 'projects/index'
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
