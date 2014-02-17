class AddPercentWeightChangeToUsers < ActiveRecord::Migration
  	class ::User < ActiveRecord::Base
  	end

	def change
  		add_column :users, :percentWeightChange, :float, default: 0, null: false

  		User.all.each do |u|
  			u.update_attribute(:percentWeightChange, u.currentPercentWeightChange)
  			u.save!
  		end

  	end


end
