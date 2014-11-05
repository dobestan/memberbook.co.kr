module MessagesHelper
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
