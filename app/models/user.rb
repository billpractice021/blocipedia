class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :username, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, dependent: :destroy

  has_many :collaborations

  has_many :wiki_collaborations, through: :collaborations, source: :wiki 
  
  has_many :charges

  enum role: {standard: 0, premium: 1, admin: 2}
end

