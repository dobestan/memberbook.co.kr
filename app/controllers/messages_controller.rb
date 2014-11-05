class MessagesController < ApplicationController
  include MessagesHelper

  def index
    render text: SMS_API.send_SMS(dest_phone: "01022205736", msg_body: "test")
  end
end
