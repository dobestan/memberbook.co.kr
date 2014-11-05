module MessagesHelper
  class SMS_API
    def SMS_API.send_SMS(kwargs)
      send_time = kwargs[:send_time] if kwargs[:send_time]
      dest_phone = kwargs[:dest_phone] if kwargs[:dest_phone] # 없을 경우에는 예외처리 필요
      send_phone = kwargs[:send_phone] ? kwargs[:send_phone] : "01022205736"
      msg_body = kwargs[:msg_body] if kwargs[:msg_body] # 없을 경우에는 예외처리
      apiVersion = kwargs[:apiVersion] ? kwargs[:apiVersion] : "1"
      id = kwargs[:id] ? kwargs[:id] : "dobestan"

      # 이 함수에 대한 구현은 기본적으로 API Store에서 제공하는 소스를 사용하였다.
      # 다만 조금 더 추상화하여 사용할 수 있도록 한다.

      #api request method
      httpmethod = "POST"

      #api url
      url = "http://api.openapi.io/ppurio/1/message/sms/dobestan"

      #api parameters
      parameters = {}
      parameters = parameters.merge({"send_time" => send_time})
      parameters = parameters.merge({"dest_phone" => dest_phone})
      parameters = parameters.merge({"send_phone" => send_phone})
      parameters = parameters.merge({"msg_body" => msg_body})
      parameters = parameters.merge({"apiVersion" => apiVersion})
      parameters = parameters.merge({"id" => id})

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
