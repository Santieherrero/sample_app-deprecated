FactoryGirl.define do 
	factory :user do
		sequence(:name) { |n| "Person #{n}"}
		sequence(:email) { |n| "person_#{n}@example.org"}
		password "wololo"
		password_confirmation "wololo"


		factory :admin do 
			admin true
		end
	end
end

