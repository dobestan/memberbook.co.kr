class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
    	t.string :writer
    	t.string :title
    	t.text :content
    	t.integer :count
    	# 게시글의 등급. 예 ( 공지사항, 일반글 )
      # 0: 일반글
      # 1: 공지글
    	t.integer :level
      t.integer :group_id

      t.timestamps
    end
  end
end
