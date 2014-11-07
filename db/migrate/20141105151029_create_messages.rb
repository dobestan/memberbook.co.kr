class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :message_group
      t.integer :result

      # 추후에 업데이트 되어야하는 정보
      #   - 받는 사용자 정보

      t.timestamps
    end
  end
end
