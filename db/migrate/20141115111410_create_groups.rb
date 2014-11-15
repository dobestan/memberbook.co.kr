class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.string :name
    	t.integer :point

      t.timestamps
    end
  end
end
