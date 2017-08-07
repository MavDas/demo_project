class UserMailer < ApplicationMailer
	
	def send_admin_mail(user)
		@user = user
		@admin = User.find(@user.invited_by_id)
		mail(:to => @admin.email,:from => @user.email, :subject => "Invite Accepted")	
	end

end
