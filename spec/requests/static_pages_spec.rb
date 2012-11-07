require 'spec_helper'

describe "Static Pages" do

	#nos dice que el subject de los test sera page 
	#por lo que no sera necesario llamar a la instace page

	subject{ page }

describe "Home Page" do

	#forma refactorizada

	before{ visit root_path }

	it{ should have_selector('h1', text: 'Sample App')}
	it{should_not have_selector('title', text: title_bar('Home')) }
	it{should have_selector('title', text: title_bar(''))}
	
end
 

 describe "Help Page" do

	#forma antigua 

	before{ visit help_path }

	it "should have the content 'Help'" do
		page.should have_selector('h1', text: 'Help')
	end
	it "should have the right title" do
		page.should have_selector('title', text: "| Help")
	end
	
end 


	describe "About us" do

 	before{ visit about_path }
	
	it{ should have_selector('title', text: title_bar('About'))}
	it{ should have_selector('h1', text: 'About us') }

	end


	it "should have the right links on the layout" do
		
	visit root_path
	click_link "About"
	should have_selector 'title',text: title_bar('About')
	click_link "Help"
	should have_selector 'title',text: title_bar('Help') 
	click_link "Home"
	should_not have_selector 'title',text: title_bar('Home') 
	click_link "Sign up now!"
	should have_selector 'title',text: title_bar('Sign up') 


	end



end