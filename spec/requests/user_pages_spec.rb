require 'spec_helper'

describe "User Pages" do

	subject { page }

	describe "sign up page" do
		
		before{ visit sign_up_path }
 
		it { should have_selector('h1',   text: 'Sign up')}	
		it { should have_selector('title',text: title_bar('Sign up'))}

	end

	describe "profile  page" do
		let(:user) { FactoryGirl.create(:user)} #usar spork para que funcione

		before{ visit user_path(user) }

		it { should have_selector('h1',   text: user.name)}	
		it { should have_selector('title',text: user.name)}

	end


	describe "Sign up" do

		before { visit sign_up_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User,:count)
			end
		end

		describe "after submission" do

			before { click_button submit }

			it{ should have_selector('title', text: 'Sign up')}
			it{ should have_content('error')}
			it{ should_not have_content('Password digest')}

		end

		describe "with valid information" do

			before do
				fill_in "Name", 			with: "Santiago"
				fill_in "Email", 			with: "xantiago@gmail.com"
				fill_in "Password", 		with: "wololo"
				fill_in "Confirmation", 	with: "wololo"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User,:count).by(1)
			end
		

			describe "after saving a user" do
				
				before{ click_button submit }

				let(:user) { User.find_by_email("xantiago@gmail.com")}

				it{ should have_selector('title', text: user.name ) } 
				it{ should have_selector('div.alert.alert-success', text: 'Welcome')}
			end

		end
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user)}

		
		before do
			# al restringin tenemos que logear para visitar edit path
			sign_in(user)
			visit edit_user_path(user)
		end



		describe "page" do
		

			it { should have_selector('h1', text: "Update your profile")}
			it { should have_selector('title', text: "Edit User")}
			it { should have_link('change', href: 'http://gravatar.com/emails')}
		end

		describe "with invalid information" do

			before { click_button "Save changes"}

			it{ should have_content('error')}
		end

		describe "with valid information" do
			let(:new_name) { "New Name"}
			let(:new_email) { "new@example.com"}
			before do
				fill_in "Name",                with: new_name
				fill_in "Email",               with: new_email
				fill_in "Password",            with: user.password
				fill_in "Confirmation",        with: user.password
				click_button "Save changes"
			end

			it { should have_selector('title', text: new_name)}
			it { should have_link('Sign out', href: sign_out_path)}
			it{ should have_selector('div.alert.alert-success')}
			specify { user.reload.name.should == new_name}
			specify { user.reload.email.should == new_email}
		end



	end







end