class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.string :name
    	t.integer :point
    	# level : 그룹의 등급 ( EMBA : 0 level, EMBA 의 건설경영 : 1 level )
    	t.integer :level
      t.integer :code
    	t.integer :parent_id

      t.timestamps
    end
  end
end
