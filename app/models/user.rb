class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  belongs_to :role
  has_many :items
  validates_presence_of :name
  before_save :assign_role

  

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def accept_invitation!
    send_invite_mail
    super
  end

  def after_confirmation
    send_user_mail
  end

  def assign_role
 		self.role = Role.find_by name: "Regular" if self.role.nil?
 	end

 	def admin?
 		self.role.name == "Admin"
 	end
 	
 	def seller?
 		self.role.name == "Seller"
 	end

 	def regular?
 		self.role.name == "Regular"
 	end
 	
 	def active_for_authentication?
 		super && approved?
 	end

 	def inactive_message
 		if !approved?
 			:not_approved
 		else
 			super
 		end
 	end

  def self.from_omniauth(auth)              # getting info from user social account and assigning them in table    
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.nickname || auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.skip_confirmation!               # if user is following social account registration,then email confirmation is ignonred
    end
  end

  def self.new_with_session(params, session)         #creating session for an existing user
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.email = data["email"] if user.email.blank? and params[:provider] == 'facebook'
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?                            # password validation is avoided as authentication is done using registered accounts
    super && provider.blank?
  end
  
  def update_with_password(params, *options)        # to handle field which need current password in oder to update to a new password
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

 	def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
     recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

  private
    def send_user_mail
      UserMailer.send_welcome_email(self).deliver_later
    end
    
    def send_invite_mail
      UserMailer.send_admin_mail(self).deliver_later
    end
end
