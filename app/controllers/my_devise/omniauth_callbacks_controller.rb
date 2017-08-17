class MyDevise::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
 

  def all # all is Alias which will be called for facebook,google+ login
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?  # if user is found then he is logged in otherwise redirected to registration page
      flash.notice = "Account Sccessfully authenticated."
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes # if user is new then registration is done using omniauth
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all

  
end
