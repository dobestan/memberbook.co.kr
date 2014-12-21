class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name
      t.string :degree, :default => ""
      t.string :group_name, :default => ""
      t.string :major, :default => ""
      t.string :student_number, :default => ""
    	t.string :phone_number, :default => ""
    	t.string :email, :default => ""
    	t.string :profile_img_name
    	t.string :grade, :default => ""
    	t.string :address, :default => ""
      t.string :company, :default => ""
      t.string :register, :default => ""
      t.string :position, :default => ""
    	t.date :birthday, :default => ""
    	
      t.timestamps
    end
  end
end
