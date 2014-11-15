class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :phone_number
    	t.string :email
    	t.string :profile_img_name
    	t.string :grade
    	t.string :address
    	t.date :birthday
    	
      t.timestamps
    end
  end
end
