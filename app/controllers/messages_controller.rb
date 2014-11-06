class MessagesController < ApplicationController
  include MessagesHelper

  def index
    render text: SMS_API.send_SMS(dest_phone: "01022205736", msg_body: "test")
  end

  def result
    render text: SMS_API.get_SMS_result(cmid: "201411061547278554370")
  end
end
