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

#Para leer la base de datos de mysql archivo : develoment.sqlite3
class User < ActiveRecord::Base
  attr_accessible :email, :name

  before_save { |user| user.email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #Hecho en Rubular
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
  			uniqueness: { case_sensitive: false }

end

