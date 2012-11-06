require 'spec_helper'

describe "Static Pages" do

describe "Home Page" do
	
	it "should have the content 'Sample app'" do
	  
		visit '/static_pages/home'
		page.should have_selector('h1', text: 'Sample App')
		
	end

	it "should have the right title" do
	  
		visit '/static_pages/home'
		page.should have_selector('title', text: "| Home") #Esta para que falle
	end

	it "should have the base title" do
		visit '/static_pages/home'
		page.should have_selector('title', text: "Ruby on Rails")
		
	end
end
 

 describe "Help Page" do
	
	it "should have the content 'Help'" do
	  
		visit '/static_pages/help'
		page.should have_selector('h1', text: 'Help')
	end
	it "should have the right title" do
	  
		visit '/static_pages/help'
		page.should have_selector('title', text: "| Help")
	end
	
end 


 describe "About us" do
	
	it "should have the content 'about'" do
	  
		visit '/static_pages/about'
		page.should have_selector('h1', text: 'About us')
	end	

	it "should have the right title" do
	  
		visit '/static_pages/about'
		page.should have_selector('title', text: "| About us")
	end

end 




end