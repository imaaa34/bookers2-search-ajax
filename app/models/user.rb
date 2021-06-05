class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)

    unless self == other_user
      self.active_relationships.find_or_create_by(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.active_relationships.find_by(followed_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(user)
    following.include?(user)
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}


  def self.looks(searches, words)
		if searches == 'perfect_match'
			@users = User.where("name LIKE?","#{words}")
		elsif searches == 'forward_match'
			@users = User.where("name LIKE?","#{words}%")
		elsif searches == 'back_match'
			@users = User.where("name LIKE?","%#{words}")
		elsif searches == 'partial_match'
			@users = User.where("name LIKE?","%#{words}%")
		else
			@users = User.all
		end
	end


end
