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

  get :logout, :map => '/logout' do
    set_current_account(nil)
    redirect url(:users, :login)
  end

  get :register, :map => '/register' do
    @account = Account.new
    render 'users/register'
  end

  get :thankyou, :map => '/thankyou' do
    render 'users/register_thankyou'
  end

  post :login, :map => '/login' do
    if account = Account.authenticate(params[:email], params[:password])
      set_current_account(account)
    else
      params[:email], params[:password] = h(params[:email]), h(params[:password])
      flash[:warning] = "Email or password incorrect."
      render 'users/login'
    end
  end

  post :register, :map => '/register' do
    @account = Account.new(params[:account])

    # Assign default role, user
    @account.role = 'user'

    if @account.save
      redirect url(:users, :thankyou)
    else
      render 'users/register'
    end
  end

end
