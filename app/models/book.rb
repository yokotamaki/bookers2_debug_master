class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments
	has_many :favorites, dependent: :destroy
	
	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end	
	
  def Book.search(search,keyword)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{keyword}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE(?)","%#{keyword}%")
    elsif search == "forward_match"
      @book = Book.where("title LIKE(?)","#{keyword}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE(?)","%#{keyword}")
    else
      @book = Book.all
    end
  end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
