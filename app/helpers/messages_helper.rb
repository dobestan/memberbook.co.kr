module MessagesHelper
  class SMS_API
    def SMS_API.send_SMS(kwargs)
      # 이 부분은 매번 변경되는 부분
      send_time = kwargs[:send_time] if kwargs[:send_time]
      send_phone = kwargs[:send_phone] ? kwargs[:send_phone] : ENV["API_SMS_send_phone"]

      # 이 부분은 매번 변경되고 예외처리가 필요한 부분
      # 예외처리는 일단 클라이언트단에서도 확실히 차단하되, 혹시나 모를 경우를 대비해서 서버단에서도 예외 발생
      # SMS_API 모듈을 호출하는 곳에서 예외처리를 해서 사용자한테 알람을 뿌려주기
      raise ArgumentError, "반드시 수신자 전화번호가 입력되어야 합니다." if kwargs[:dest_phone].nil?
      raise ArgumentError, "반드시 메시지 본문 내용이 입력되어야 합니다." if kwargs[:msg_body].nil?

      # 이 부분은 자주 변경되지 않는 부분
      apiVersion = kwargs[:apiVersion] ? kwargs[:apiVersion] : ENV["API_SMS_apiVersion"]
      id = ENV["API_SMS_id"]

      # 이 함수에 대한 구현은 기본적으로 API Store에서 제공하는 소스를 사용하였다.
      # 다만 조금 더 추상화하여 사용할 수 있도록 한다.

      #api request method
      httpmethod = "POST"

      #api url
      url = "http://api.openapi.io/ppurio/1/message/sms/" + ENV["API_SMS_id"]

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
      clientKey = ENV["API_SMS_clientKey"]

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
