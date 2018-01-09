class Micropost < ActiveRecord::Base
  belongs_to :user
  #The arrow -> is called the proc, which "takes in a block and
  # evaluates it with a call method"
  default_scope -> {order('created_at DESC')} #Created at descending order
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true

end
