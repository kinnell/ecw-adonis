class Weighin < ActiveRecord::Base
	include WeighinsHelper
	include MathHelper

	belongs_to :user, touch: true
	validates :weight, presence: true, numericality: { greater_than: 0 }

	default_scope { order("weighins.created_at ASC") }
	scope :verified, -> { where(verified: true) }

 	def weighinWeek() if created_at < Time.parse("08/01/2014") then 0 else ((created_at - Time.parse("05/01/2014"))/604800).ceil end end

	def weightChange() user.weightChange weight end

	def weightPercentChange() user.weightPercentChange weight end

end

