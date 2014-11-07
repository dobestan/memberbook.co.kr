class MessagesController < ApplicationController
  include MessagesHelper

  def send_sms
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
      body: "여기에 실제로 발송되는 컨텐츠",
      message_type: 1
    )

    send_to_list.each do |send_to|
      message = message_group.messages.new()
      response = JSON.parse SMS_API.send_SMS(dest_phone: send_to, msg_body: message_group.body)
      message.result = response["result_code"]
      message.cmid = response["cmid"]
      message.save()
    end

    render text: "success"
  end

  def index
    response = JSON.parse SMS_API.send_SMS(dest_phone: "01022205736", msg_body: "TEST")
    render json: response

    # cmid = response["cmid"]
    # send_result = SMS_API.get_SMS_result(cmid: cmid)
    # render json: send_result
    #
    # 일단 이번 테스트 결과로 알 수 있었던 사실은 ...
    #   - 보낸 즉시 Report를 확인할 수 없다.
    #   - 그렇다면 앞으로 해결해야할 이슈는 "언제 결과를 받아올 것인가"
    #   - 이거는 sidekiq 같은 스케쥴러(?)를 사용하면 해결할 수 있지 않을까?
  end

  def send_email
    render json: EMAIL_API.send_email(
      to: "dobestan@gmail.com",
      subject: "테스트",
      text: "본 이메일은 테스트 목적으로 발송되었습니다."
    )
  end

  def result
    render json: SMS_API.get_SMS_result(cmid: "201411061547278554370")
  end
end
