class CreateMessageGroups < ActiveRecord::Migration
  def change
    create_table :message_groups do |t|
      # 이 모델은 왜 만들어지게 되었나?
      # 일단 전체적으로 메시지 ( 카카오톡, 이메일, 푸쉬 등 ) 을 관리하기 위해서 만들어졌다.

      # 추후에 업데이트 되어야하는 정보
      #   - 보낸 사용자 정보
      #   - 보낸 사용자가 포함된 집단 정보
      #   - 보낸 메시지 정보

      t.string :body
      t.integer :type

      t.timestamps
    end
  end
end
