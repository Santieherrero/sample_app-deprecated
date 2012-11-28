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
end