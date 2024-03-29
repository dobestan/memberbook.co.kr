module MessagesHelper
  # 일단 문자보내기, 이메일 발송하기는
  # 단순히 API를 사용하는 것이므로 여기서 구현되어야 한다.
  #
  # 다만, 단체 문자 보내기 혹은 단체 이메일 보내기 기능은
  # 컨트롤러 / 모델에서 구현되어야 한다.

  class EMAIL_API
    def EMAIL_API.send_email(kwargs)
      raise ArgumentError, "반드시 to가 입력되어야 합니다." if kwargs[:to].nil?
      raise ArgumentError, "반드시 subject가 입력되어야 합니다." if kwargs[:subject].nil?
      raise ArgumentError, "반드시 text가 입력되어야 합니다." if kwargs[:text].nil?

      httpmethod = "POST"
      url = "https://api:" + ENV["API_MAILGUN_key"] + "@" + ENV["API_MAILGUN_base_url"] + "/messages"

      if kwargs[:from]
        from = kwargs[:from]
      else
        # 발신자 정보가 주어지지 않으면,
        # 기본적으로 contact@memberbook.co.kr 을 기준으로 발송
        from = ENV["API_MAILGUN_default_send_username"] + " <" + ENV["API_MAILGUN_default_send_email"]+ ">"
      end

      #api parameters
      parameters = {}
      parameters = parameters.merge({"from" => from})
      parameters = parameters.merge({"to" => kwargs[:to]})
      parameters = parameters.merge({"subject" => kwargs[:subject]})
      parameters = parameters.merge({"text" => kwargs[:text]})

      response = HttpClient.do_request(httpmethod: httpmethod, url: url, parameters: parameters)

      #api response
      return response
    end
  end

  class SMS_API
    # 한글 40자 까지는SMS로 전송( 80 byte )
    # 한글 41자 이상부터는 LMS로 전송
    # 과금에 대한 부분은 클라이언트에서 처리하기

    def SMS_API.get_SMS_result(kwargs)
      # GET 요청 보낼 URL을 생성하기 위해 추가되었다.
      require 'addressable/uri'

      raise ArgumentError, "반드시 cmid가 입력되어야 합니다." if kwargs[:cmid].nil?

      httpmethod = "GET"
      url = "http://api.openapi.io/ppurio/" + ENV["API_SMS_apiVersion"] + "/message/report/" + ENV["API_SMS_id"]

      #api parameters
      parameters = {}
      parameters = parameters.merge({"cmid" => kwargs[:cmid]})
      parameters = parameters.merge({"id" => "dobestan"})

      #request header (contentType, clientKey)
      contentType = "application/x-www-form-urlencoded"
      clientKey = ENV["API_SMS_clientKey"]

      headers = {}
      headers = headers.merge({"x-waple-authorization" => (clientKey).chomp.gsub(/\n/,'')})
      headers = headers.merge({"Content-Type" => "application/x-www-form-urlencoded"})

      #send request
      response = HttpClient.do_request(
        url: url,
        httpmethod: httpmethod,
        parameters: parameters,
        headers: headers
      )

      #api response
      return response
    end

    def SMS_API.send_SMS(kwargs)
      # 이 부분은 매번 변경되는 부분
      send_time = kwargs[:send_time] if kwargs[:send_time]
      send_phone = kwargs[:send_phone] ? kwargs[:send_phone] : ENV["API_SMS_send_phone"]

      # 이 부분은 매번 변경되고 예외처리가 필요한 부분
      # 예외처리는 일단 클라이언트단에서도 확실히 차단하되, 혹시나 모를 경우를 대비해서 서버단에서도 예외 발생
      # SMS_API 모듈을 호출하는 곳에서 예외처리를 해서 사용자한테 알람을 뿌려주기
      raise ArgumentError, "반드시 수신자 전화번호가 입력되어야 합니다." if kwargs[:dest_phone].nil?
      raise ArgumentError, "반드시 메시지 본문 내용이 입력되어야 합니다." if kwargs[:msg_body].nil?

      dest_phone = kwargs[:dest_phone]
      msg_body = kwargs[:msg_body]

      # 이 부분은 자주 변경되지 않는 부분
      apiVersion = kwargs[:apiVersion] ? kwargs[:apiVersion] : ENV["API_SMS_apiVersion"]
      id = ENV["API_SMS_id"]

      # 이 함수에 대한 구현은 기본적으로 API Store에서 제공하는 소스를 사용하였다.
      # 다만 조금 더 추상화하여 사용할 수 있도록 한다.

      #api request method
      httpmethod = "POST"

      #api url
      # 일단 80byte가 넘어가면 자동으로 LMS로 변경 ( API 에서 제공하는 기능 )
      # 우리가 신경쓰지 않아도 되는 부분
      url = "http://api.openapi.io/ppurio/" + ENV["API_SMS_apiVersion"] + "/message/sms/" + ENV["API_SMS_id"]

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

      headers = {}
      headers = headers.merge({"x-waple-authorization" => (clientKey).chomp.gsub(/\n/,'')})
      headers = headers.merge({"Content-Type" => "application/x-www-form-urlencoded"})

      #send request
      response = HttpClient.do_request(
        url: url,
        httpmethod: httpmethod,
        parameters: parameters,
        headers: headers
      )

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

    def HttpClient.do_request(kwargs)
      return internal_do_request(kwargs)
    end

    def HttpClient.setResponse(output_response)
           output_response.body = output_response.raw_body
    end

    def HttpClient.internal_do_request(kwargs)
      # 필수 파라미터
      #   - url
      raise ArgumentError, "반드시 url이 입력되어야 합니다." if kwargs[:url].nil?
      url = kwargs[:url]

      # 옵션 파라미터
      #   - method
      #   - parameters
      #   - headers
      httpmethod = kwargs[:httpmethod] ? kwargs[:httpmethod] : "GET"
      parameters = kwargs[:parameters] ? kwargs[:parameters] : {}
      headers = kwargs[:headers] ? kwargs[:headers] : {}

      httpResponse = nil;

      begin
        case httpmethod
          when httpmethod = "GET"
            uri = Addressable::URI.new
            uri.query_values = parameters
            httpResponse = RestClient.get url + "?" + uri.query, headers
          when httpmethod = "POST"
            httpResponse = RestClient.post url, parameters, headers
          when httpmethod = "PUT"
            httpResponse = RestClient.put url, parameters, headers
          when httpmethod = "DELETE"
            httpResponse = RestClient.delete url, parameters, headers
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
