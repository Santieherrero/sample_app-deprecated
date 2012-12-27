include ApplicationHelper

def sign_in(user)
	visit sign_in_path
	fill_in "Email", with: user.email 
	fill_in "Password", with: user.password
	click_button "Sign in" 
	#no funciona pues no reconoce las cookies
	#sign in when not using Capubara.
	cookies[:remember_token] = user.remember_token
end