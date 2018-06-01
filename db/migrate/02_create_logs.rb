class CreateLogs < ActiveRecord::Migration
	def change
		create_table :logs do |t|
			t.string :date
			t.integer :swim_distance
			t.integer :bike_distance
			t.integer :run_distance
			t.integer :user_id
		end
	end
end