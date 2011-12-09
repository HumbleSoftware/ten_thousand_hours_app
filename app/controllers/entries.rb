TenThousandHoursApp.controllers :entries, :parent => :projects do

  post :create do
    @project = Project.get(params[:project_id])
    @entry = Entry.new(params[:entry])
    @entry.project = @project
    if @entry.save
      redirect back
    else
      render 'projects/show'
    end
  end

end
