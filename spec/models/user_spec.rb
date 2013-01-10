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
#  remember_token  :string(255)
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
	it{ should respond_to(:admin)}
	it{ should respond_to(:microposts)}
	it{ should respond_to(:remember_token)}
	it{ should respond_to(:feed)}
	it{ should respond_to(:relationships)}
	it{ should respond_to(:followed_users)}
	it{ should respond_to(:reverse_relationships)}
	it{ should respond_to(:followers)}
	it{ should respond_to(:following?)}
	it{ should respond_to(:follow!)}
	it{ should respond_to(:unfollow!)}



	it{ should be_valid }
	it{ should_not be_admin}


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
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. 
						foo@bar_baz.com foo@go+fo]
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

	describe "remember token" do
		before { @user.save }
		it "should have a noblank remember token" do
			subject.remember_token.should_not be_blank
			
		end
	end

	describe "micropost associations" do
		before { @user.save }

		let!(:older_micropost) do
			FactoryGirl.create(:micropost,user: @user,created_at: 1.day.ago)
		end
		let!(:newer_micropost) do
			FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right micropost in the right order" do
			@user.microposts.should == [newer_micropost, older_micropost]
		end
	
		it "should destroy associated micropost" do
			micropost = @user.microposts
			@user.destroy
			micropost.each do |micropost|
				Micropost.find_by_id(micropost.id).should be_nil
			end
		end

		
		describe "status" do

			let(:unfollowed_post) do  
				FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
			end

			its(:feed) { should include(older_micropost)  }
			its(:feed) { should include(newer_micropost)  }
			its(:feed) { should_not include(unfollowed_post)  }
		end


		describe "following" do
			let(:other_user){ FactoryGirl.create(:user) }

			before do
			  @user.save
			  @user.follow!(other_user)
			end

			it { should be_following(other_user)}

			its(:followed_users) { should include(other_user) }

			describe "followed user" do
				subject { other_user }
				its(:followers) { should include(@user) }
			end

			describe "and unfollowing" do
				before { @user.unfollow!(other_user)}

				it{ should_not be_following(other_user)}
				its(:followed_users) { should_not include(other_user) }
			end
		end
	

	end




end
	
