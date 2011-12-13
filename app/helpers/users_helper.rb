# Helper methods defined here can be accessed in any controller or view in the application

TenThousandHoursApp.helpers do
  def user_has_valid_reset(email, key)
    account = Account.first(:email => email)
    if account
      @reset = Reset.first(:account_id => account.id, :password_key => key)
      !@reset.used if @reset
    end
  end

  def user_reset_email
    body_content = "This email has been sent to let you reset your password.\n\n"
    body_content += "Click to reset your password:\n" 
    body_content += base_url + url(
      :users, :reset,
      :key => @reset.password_key,
      :email => @account.email
    )
    body_content += "\n\n-10000 hours\n" 
    body_content
  end

  def base_url
    @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
  end
end
