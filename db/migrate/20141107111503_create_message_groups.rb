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
      t.integer :message_type # 0 번은 혹시나 type을 명시하지 않은 경우를 대비하기 위해서 사용하지 말자
                              # 1 번 : SMS
                              # 2 번 : LMS
                              # 3 번 : MMS ( 다만, 처음에는 MMS를 지원하지 않는다. )
                              # 4 번 : Email
                              #
                              # 여기서부터는 추후 개발
                              # 5 번 : Push 등
      end
    end
end
