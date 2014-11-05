class MessagesController < ApplicationController
  include MessagesHelper

  def index
    #api request method
    httpmethod = "POST"

    #api url
    url = "http://api.openapi.io/ppurio/1/message/sms/dobestan"

    #api parameters
    parameters = {}
    parameters = parameters.merge({"send_time" => ""})
    parameters = parameters.merge({"dest_phone" => "01022205736"})
    parameters = parameters.merge({"send_phone" => "01022205736"})
    parameters = parameters.merge({"msg_body" => "SMS TEST"})
    parameters = parameters.merge({"apiVersion" => "1"})
    parameters = parameters.merge({"id" => "dobestan"})

    #request header (contentType, clientKey)
    contentType = "application/x-www-form-urlencoded"
    clientKey = "MTkyMC0xNDEzODU0NTAwMzU3LTllM2VkOTM3LTYwMTEtNGU2Zi1iZWQ5LTM3NjAxMTNlNmYyMg=="

    #send request
    response = MessagesHelper::HttpClient.do_request(httpmethod, url, parameters, clientKey, contentType)

    #api response
    render text: response
  end
end
