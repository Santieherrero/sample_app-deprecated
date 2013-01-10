require 'spec_helper'

describe "Static Pages" do

	#nos dice que el subject de los test sera page 
	#por lo que no sera necesario llamar a la instace page

	subject{ page }

	describe "Home Page" do

		#forma refactorizada
		before{ visit root_path }

		it{ should have_selector('h1', text: 'Sample App')}
		it{ should_not have_selector('title', text: title_bar('Home')) }
		it{ should have_selector('title', text: title_bar(''))}



		describe "for signed-in users" do
				let(:user) { FactoryGirl.create(:user) }

				before do
					FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
					FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
					sign_in user
					visit root_path
				end

				it "should render the user's feed" do
					user.feed.each do |item|
						page.should have_selector("li##{item.id}", text: item.content)
					end
				end

				describe "follower/following counts" do
					let(:other_user) { FactoryGirl.create(:user) }
					before do
					  other_user.follow!(user)
					  visit root_path
					end

					it {should have_link("0 following", href: following_user_path(user))}
					it {should have_link("1 follower", href: followers_user_path(user))}
					
				end
		end
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
		click_link "Sign in"
		should have_selector 'title',text: title_bar('Sign in')
	end
end