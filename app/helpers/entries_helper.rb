# Helper methods defined here can be accessed in any controller or view in the application

TenThousandHoursApp.helpers do
  def format_time(time)
    (time / 60).to_s + ':' + (time % 60).to_s
  end
end
