# Helper methods defined here can be accessed in any controller or view in the application

TenThousandHoursApp.helpers do

  def project_owned_by_current_user
    @project = Project.get(params[:project_id])
    @project.account == current_account
  end

  # def simple_helper_method
  #  ...
  # end
end
