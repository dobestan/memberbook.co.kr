class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :message_group
      t.integer :result
      t.string :cmid # 이거는 SMS 에서 저장되는 정보

      # 추후에 업데이트 되어야하는 정보
      #   - 받는 사용자 정보
    end
  end
end
