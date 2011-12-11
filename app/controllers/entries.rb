TenThousandHoursApp.controllers :entries, :parent => :projects do

  get :index do
    @project = Project.get(params[:project_id])
    @entries = Entry.all(:project_id => @project.id)
    render 'entries/index'
  end

  post :create do

    @entry = Entry.new(params[:entry])
    @project = Project.get(params[:project_id])
    @entry.project = @project

    if (params[:entry][:time].match(':'))
      hours, minutes = params[:entry][:time].split(':')
      @entry.time = hours.to_i * 60 + minutes.to_i
    end

    if @entry.save
      redirect url_for(:projects, :show, @project.id)
    else
      render 'projects/show'
    end
  end

end
