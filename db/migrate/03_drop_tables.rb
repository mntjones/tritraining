class DropTables < ActiveRecord::Migration
	def change
		drop_table :users
		drop_table :logs
		end

end