module UsersHelper

	def gravatar_for(user, option = {size: 50})
		email_id = Digest::MD5::hexdigest(user.email.downcase)
		size = option[:size]
		gravatar_link = "https://secure.gravatar.com/avatar/#{email_id}?s=#{size}"
		image_tag(gravatar_link,alt: user.name + " avatar",class: "gravatar")
	end


end
