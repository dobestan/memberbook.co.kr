class MessagesController < ApplicationController
  include MessagesHelper

  def index
    render text: SMS_API.send_SMS
  end
end
