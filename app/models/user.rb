class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /change@me/
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  belongs_to :role
  has_many :items
  validates_presence_of :name
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :submit
  before_save :assign_role

   def self.from_omniauth_f(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      user = User.new(email: auth.info.email,
        password: Devise.friendly_token[0,20], 
        name: auth.info.name)
      user.skip_confirmation!
      user.save!
    end
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def self.from_omniauth_g(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    #Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data['name'],
        email: data['email'],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end

 

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
