class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :email_regexp => /\A[\w+\-.]+@eclinicalworks.com/i

   validates_format_of :email, :with=>email_regexp, :allow_blank => true, :message=>"needs to be an eClinicalWorks email."      
   validates :name, presence: true

   has_many :weighins

	def self.visible
		where(visible: true)
	end

	def latestWeightPercentChange
		weighins.last.weightPercentTotalChange
	end

	def self.withWeighins
		usersWithWeighins = Array.new

		User.all.each do |u|			
			usersWithWeighins = usersWithWeighins + [u] unless (u.weighins.blank?)
		end
		
		return usersWithWeighins

	end

end
