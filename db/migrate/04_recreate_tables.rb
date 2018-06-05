class RecreateTables < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.string :username
			t.string :email
			t.string :password_digest
		end


		create_table :logs do |t|
			t.string :date
			t.integer :swim_distance
			t.integer :bike_distance
			t.integer :run_distance
			t.integer :user_id
		end
	end
end
