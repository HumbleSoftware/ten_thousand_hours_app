TenThousandHoursApp.controllers :vis do

  layout :vis

  get :index, :with => :project_id do
    @project = Project.get(params[:project_id])
    render 'vis/vis'
  end

end
