require 'spec_helper'

describe "User Pages" do

	subject { page }

	describe "sign up page" do
		
		before{ visit sign_up_path }

		it { should have_selector('h1',   text: 'Sign up')}	
		it { should have_selector('title',text: title_bar('Sign up'))}

	end
end
