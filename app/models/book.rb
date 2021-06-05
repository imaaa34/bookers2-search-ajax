class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}


	def self.looks(searches, words)
		if searches == 'perfect_match'
			@books = Book.where("title LIKE?","#{words}")
		elsif searches == 'forward_match'
			@books = Book.where("title LIKE?","#{words}%")
		elsif searches == 'back_match'
			@books = Book.where("title LIKE?","%#{words}")
		elsif searches == 'partial_match'
			@books = Book.where("title LIKE?","%#{words}%")
		else
			@books = Book.all
		end
	end

end
