class Weighin < ActiveRecord::Base
	belongs_to :user
	validates :weight, presence: true, numericality: { greater_than: 0 }

end

