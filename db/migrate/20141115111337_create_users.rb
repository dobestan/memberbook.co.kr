class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name
      t.string :degree
      t.string :group_name
      t.string :major
      t.string :student_number
    	t.string :phone_number
    	t.string :email
    	t.string :profile_img_name
    	t.string :grade
    	t.string :address
      t.string :company
      t.string :register
      t.string :position
    	t.date :birthday
    	
      t.timestamps
    end
  end
end
