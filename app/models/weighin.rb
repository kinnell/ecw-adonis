class Weighin < ActiveRecord::Base
	include MathHelper
	include PrintHelper

	belongs_to :user, touch: true, counter_cache: true
	validates :weight, presence: true, numericality: { greater_than: 0 }

	default_scope { order("weighins.created_at ASC") }
	scope :verified, -> { where(verified: true) }

	delegate :name, :to => :user, :prefix => true

 	def weighinWeek() if created_at < Time.parse("08/01/2014") then 0 else ((created_at - Time.parse("05/01/2014"))/604800).ceil end end

	def weightChange() weight - user.firstWeight end
	def percentWeightChange() percentChange(user.firstWeight, weight) end

end

