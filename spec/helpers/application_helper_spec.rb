require 'spec_helper'

describe ApplicationHelper do
	
	describe "title_bar" do

		it "should include the page title" do
			title_bar('foo').should =~ /foo/
		end
		
		it "should include the base title" do
			title_bar('foo').should =~ /^Ruby on Rails/
			
		end

		it "should not include a bar on the home page" do
			title_bar('').should_not =~ /\//
		end

	end

end