class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :email_regexp => /\A[\w+\-.]+@eclinicalworks.com/i

   validates_format_of :email, :with=>email_regexp, :allow_blank => true, :message=>"needs to be an eClinicalWorks email."      
   validates :name, presence: true

   has_many :weighins, dependent: :destroy
   belongs_to :team, touch: true

   default_scope { order("users.id ASC") }

   include MathHelper

	def self.visible() where(visible: true) end
	def self.paid() where(paid: true) end

	def self.withWeighins() joins(:weighins).distinct end
	def self.withVerifiedWeighins() joins(:weighins).where(:weighins => {:verified => true}).distinct end
	def self.withLoadedVerifiedWeighins() includes(:weighins).where(:weighins => {:verified => true}).distinct end

	def hasWeighin() weighins.present? end
	def hasVerifiedWeighin() weighins.where(verified: true).present? end

	def firstWeight() if hasVerifiedWeighin then weighins.where(verified: true).first.weight elsif hasWeighin then weighins.first.weight end end

	def currentWeighin() weighins.last end
	def currentWeight() weighins.last.weight end
	def currentVerifiedWeight() weighins.where(verified: true).last.weight end

	def weightChange (wt) if hasWeighin then (wt - firstWeight) end end
	def weightPercentChange (wt) if hasWeighin then percentChange(firstWeight, wt) end end
	def currentWeightChange() weightChange(currentWeight) end
	def currentWeightPercentChange() weightPercentChange(currentWeight) end

	def printCurrentWeightChange() if hasWeighin then currentWeighin.printWeightChange end end
	def printCurrentWeightPercentChange() if hasWeighin then currentWeighin.printWeightPercentChange end end

	def weights_as_array() weighins.pluck(:created_at, :weight).map {|d,w| {"created_at" => d, "weight" => w}} end
	def weightPercentChanges_as_array() weighins.pluck(:created_at, :weight).map {|d,w| {"created_at" => d, "percent_change" => weightPercentChange(w)}} end

	


end
