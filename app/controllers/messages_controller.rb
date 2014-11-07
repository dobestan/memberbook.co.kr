class MessagesController < ApplicationController
  include MessagesHelper

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
    render json: EMAIL_API.send_email
  end

  def result
    render json: SMS_API.get_SMS_result(cmid: "201411061547278554370")
  end
end
