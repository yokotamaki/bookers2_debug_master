class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy#フォローしている
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy#フォローされている
  
  has_many :follower_user, through: :followed, source: :follower#フォローしている人
  has_many :following_user, through: :follower, source: :followed#フォローされている人
  #フォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  #フォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  #既にフォローしているかの確認
  def following?(user)
    following_user.include?(user)
  end
  
  def self.search(search)
    if search 
      User.where('text LIKE(?)', "%#{search}%")
    else
      User.all#全て表示させる  
    end  
  end
  
  def User.search(search,keyword)
    if search == "perfect_match"
      @user = User.where("name LIKE?","#{keyword}")
    elsif search == "partial_match"
      @user = User.where("name LIKE(?)","%#{keyword}%")
    elsif search == "forward_match"
      @user = User.where("name LIKE(?)","#{keyword}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE(?)","%#{keyword}")
    else
      @user = User.all
    end
  end
  
  include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address_city, presence: true
  validates :address_street, presence: true
end
