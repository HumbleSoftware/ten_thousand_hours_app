TenThousandHoursApp.controllers :projects do

  get :index do
    render 'projects/index'
  end

  get :new do
    render 'projects/new'
  end

  post :create do
  end

end
