# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  
  #Si hacemos cambios en la base de datos recordar hacer la prepacion para
  #el test, rake db:test:prepare

	before do
	 @user = User.new(name:"Santiago", email:"santi@gmail.com", 
	 				password:"Wololo", password_confirmation:"Wololo")
	end

	subject{ @user }

	it{ should respond_to(:name)}
	it{ should respond_to(:email)}
	it{ should respond_to(:password_digest)}
	it{ should respond_to(:password)}
	it{ should respond_to(:password_confirmation)}
	it{ should respond_to(:authenticate)}

	it{ should be_valid }

	#Test para name
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

	#Test para email
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

	#test para password 

	describe "whe password is not present" do
		before { @user.password = @user.password_confirmation = "" }
		it{ should_not be_valid }
	end

	describe "When password doesn't match" do
		before { @user.password_confirmation = "voila" }
		it{ should_not be_valid }
	end

	describe "When password confirmation is nil" do
		before{ @user.password_confirmation = nil}
		it{ should_not be_valid }
	end

	describe "When password is too short" do
		before{ @user.password = @user.password_confirmation = "a" * 5}
		it { should be_invalid }
	end


	#Test para encontrar y autentificar usuarios
	describe "return value of the authenticate method" do

		before{ @user.save }
		let(:found_user) { User.find_by_email(@user.email) }


		describe "with valid password" do
			it{ should == found_user.authenticate("Wololo")}
		end

		describe "with invalid password" do
			let(:invalid_password) { found_user.authenticate("invalid") }

			specify{ invalid_password.should be_false}
		end
	end


end
	
