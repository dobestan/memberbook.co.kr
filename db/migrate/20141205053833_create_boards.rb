class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
    	t.string :writer
    	t.string :title
    	t.string :content
    	t.integer :count
    	# 게시글의 등급. 예 ( 공지사항, 일반글 )
    	t.integer :level

      t.timestamps
    end
  end
end
