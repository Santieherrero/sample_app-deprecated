module UsersHelper

	def gravatar_for(user)
		email_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_link = "http://gravatar.com/avatar/#{email_id}"
		image_tag(gravatar_link,alt: user.name + " avatar",class: "gravatar")
	end


end
