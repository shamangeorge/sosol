class Board < ActiveRecord::Base
	has_many :articles
	has_many :users
	has_many :decrees
	
	#has_many :users
	#belongs_to :user
	has_and_belongs_to_many :users
end
