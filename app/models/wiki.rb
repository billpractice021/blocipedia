class Wiki < ActiveRecord::Base
  belongs_to :user
  default_scope { order('created_at DESC') } 
  has_many :collaborations
  has_many :users, through: :collaborations
end
