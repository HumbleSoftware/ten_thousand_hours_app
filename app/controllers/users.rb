TenThousandHoursApp.controllers :users do
  # get :index, :map => "/foo/bar" do
  #   session[:foo] = "bar"
  #   render 'index'
  # end

  # get :sample, :map => "/sample/url", :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get "/example" do
  #   "Hello world!"
  # end

  get :index do
  end

  get :login, :map => '/login' do
    render 'users/login'
  end

  get :register, :map => '/register' do
    render 'users/register'
  end

  post :login, :map => '/login' do
  end

  post :register, :map => '/register' do
  end

end
