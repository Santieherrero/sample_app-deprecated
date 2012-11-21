# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  
  #Si hacemos cambios en la base de datos recordar hacer la prepacion para
  #el test, rake db:test:prepare

	before do
	 @user = User.new(name:"Santiago", email:"santi@gmail.com")
	end

	subject{ @user }

	it{ should respond_to{:name}}
	it{ should respond_to{:email}}

	it{ should be_valid }

	describe "when name is not present" do
		  before{ @user.name = " "}
		  it{ should_not be_valid }
	end

	describe "when email is not present" do
		  before{ @user.email = "  "}
		  it{ should_not be_valid }
	end

	describe "when name is too long" do
		before{ @user.name = "a" * 51}
		it{ should_not be_valid}
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

	describe "when email format is valid" do
	it "should be valid" do
			addresses = %w[user@foo.com user_at_foo@s.org example_user@foo.es]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe "when email addresses is alredy taken" do
		
		before do
		  user_same_email = @user.dup #duplica el usuario
		  user_same_email.email.upcase #en caso de que el email este en mayus pero el mismo
		  user_same_email.save #para que funcione tiene que estar puesto el spork
		end

		it { should_not be_valid }
		
	end


end
	
