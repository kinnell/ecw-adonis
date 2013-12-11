class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :email_regexp => /\A[\w+\-.]+@eclinicalworks.com/i

   validates_format_of :email, :with=>email_regexp, :allow_blank => true, :message=>"needs to be an eClinicalWorks email."      

   has_many :weighins

end
