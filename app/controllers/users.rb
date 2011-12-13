TenThousandHoursApp.controllers :users do

  get :index do
  end

  get :login, :map => '/login' do
    if logged_in?
      redirect '/'
    else
      render 'users/login'
    end
  end

  get :logout, :map => '/logout' do
    set_current_account(nil)
    redirect url(:users, :login)
  end

  get :forgot, :map => '/forgot' do
    render 'users/forgot'
  end

  get :reset, :map => '/reset' do
    render 'users/reset'
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
      redirect url(:index)
    else
      params[:email], params[:password] = h(params[:email]), h(params[:password])
      flash[:warning] = "Email or password incorrect."
      redirect url(:users, :login)
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

  post :forgot, :map => '/forgot' do
    @account = Account.first(:email => params[:email])
    if (@account)
      @reset = Reset.new
      @reset.account = @account
      if @reset.save
        # TODO save error?
        email(
          :from => '10000hours@humblesoftware.com',
          :to => @account.email,
          :subject => '10000 Hours - Reset Password',
          :body => user_reset_email
        )
      end
    end
    render 'users/reset_sent'
  end

end
