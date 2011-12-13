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
    if user_has_valid_reset params[:email], params[:key]
      render 'users/reset'
    elsif @reset
      @error_message = 'Password token already used.'
      halt 403
    else
      @error_message = 'No password reset token found with that key.'
      halt 403
    end
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

  post :reset, :map => '/reset' do
    if user_has_valid_reset params[:email], params[:key]
      @account.password = params[:password]
      @account.password_confirmation = params[:password_confirmation]
      @account.crypted_password = ''
      if @account.save
        @reset.update!(:used => true)
        flash[:notice] = "Password successfully reset."
        redirect url(:users, :login)
      else
        render 'users/reset'
      end
    else
      @error_message = 'Invalid password reset token.'
      halt 403
    end
  end

end
