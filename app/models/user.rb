class User < ActiveRecord::Base
	include MathHelper

   # Include default devise modules. Others available are:
   # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :email_regexp => /\A[\w+\-.]+@eclinicalworks.com/i

   validates_format_of :email, :with=>email_regexp, :allow_blank => true, :message=>"needs to be an eClinicalWorks email."
   validates :name, presence: true

   has_many :weighins, dependent: :destroy
   belongs_to :team, touch: true, counter_cache: true

   delegate :name, :to => :team, :prefix => true

   default_scope { order("users.id ASC") }

   #scope :visible, -> { where(visible: true) }
   #scope :paid, -> { where(paid: true) }
	#scope :withWeighins, -> { joins(:weighins).distinct }
	#scope :withVerifiedWeighins, -> { joins(:weighins).merge(Weighin.verified).distinct }

	def self.visible() where(visible: true) end
   def self.paid() where(paid: true) end
   def self.withWeighins() joins(:weighins).distinct end
   def self.withVerifiedWeighins() joins(:weighins).where(:weighins => {:verified => true}).distinct end

	def hasWeighins() self.weighins.present? end
	def hasVerifiedWeighins() weighins.where(verified: true).present? end

	def firstWeight() if hasVerifiedWeighins then weighins.where(verified: true).first.weight elsif hasWeighins then weighins.first.weight end end

	def currentWeighin() weighins.last end
	def currentWeight() weighins.last.weight end
	def currentVerifiedWeight() weighins.where(verified: true).last.weight end

	#def weightChange(wt = currentWeight) wt - firstWeight end

	def weightChange(wt) if hasWeighins then (wt - firstWeight) end end
	def percentWeightChange(wt) if hasWeighins then percentChange(firstWeight, wt) end end
	def currentWeightChange() if hasWeighins then weightChange(currentWeight) end end
	def currentPercentWeightChange() if hasWeighins then percentChange(firstWeight, currentWeight) else 0 end end

	def printCurrentWeightChange() if hasWeighins then currentWeighin.printWeightChange end end
	def printCurrentPercentWeightChange() if hasWeighins then currentWeighin.printPercentWeightChange end end

	def weights_as_array() weighins.pluck(:created_at, :weight).map {|d,w| {"created_at" => d, "weight" => w}} end
	def percentWeightChanges_as_array() weighins.pluck(:created_at, :weight).map {|d,w| {"created_at" => d, "percent_change" => percentWeightChange(w)}} end

end
