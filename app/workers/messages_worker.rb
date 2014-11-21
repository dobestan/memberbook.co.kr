class MessagesWorker
  include Sidekiq::Worker
  include MessagesHelper

  def perform
    # 여기에 어떻게든 정보가 전달된다.
    # 여기서는 실제로 발송을 하고, DB에 데이터를 저장한다.
    #
    # 일단은 리스트로 테스트하지만 추후에는
    #   - 이름 바꿔 보내기
    # 기능이 동작해야 하므로 다른 자료구조를 써야한다.

    send_to_list = [
      "01022205736",
    ]

    message_group = MessageGroup.create(
      body: "SideKiq Test",
      message_type: 1
    )

    send_to_list.each do |send_to|
      message = message_group.messages.new()
      response = JSON.parse SMS_API.send_SMS(dest_phone: send_to, msg_body: message_group.body)
      message.result = response["result_code"]
      message.cmid = response["cmid"]
      message.save()
    end
  end
end
