module MessagesHelper
  class SMS_API
    def SMS_API.send_SMS()
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
      response = HttpClient.do_request(httpmethod, url, parameters, clientKey, contentType)

      #api response
      return response
    end
  end

  class HttpResponse
    attr :code, true
    attr :raw_body, true
    attr :body, true
    attr :headers, true
  end

  class HttpClient

    def HttpClient.do_request(method, url, parameters, clientKey, content_type)
      return internal_do_request(method, url, parameters, clientKey, content_type)
    end

    def HttpClient.setResponse(output_response)
           output_response.body = output_response.raw_body
    end

    def HttpClient.internal_do_request(method, url, parameters, clientKey, content_type)
       httpResponse = nil;

       headers = {}
       headers = headers.merge({"x-waple-authorization" => (clientKey).chomp.gsub(/\n/,'')})
       headers = headers.merge({"Content-Type" => "application/x-www-form-urlencoded"})

       begin
        case method
          when method = "GET"
            uri = Addressable::URI.new
            uri.query_values = parameters
            httpResponse = RestClient.get url + "?" + uri.query, headers
          when method = "POST"
            httpResponse = RestClient.post url, parameters, headers
            puts "method ::" + method
          when method = "PUT"
            httpResponse = RestClient.put url, parameters, headers
            puts "method ::" + method
          when method = "DELETE"
            httpResponse = RestClient.delete url, parameters, headers
            puts "method ::" + method
        end
        rescue => e
          httpResponse = e.response
       end
       response = HttpResponse.new
       response.code = httpResponse.code
       response.headers = httpResponse.headers
       response.raw_body = httpResponse
       return response.raw_body
    end
  end
end
