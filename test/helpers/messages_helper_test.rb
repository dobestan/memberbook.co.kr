require 'test_helper'

class MessagesHelperTest < ActionView::TestCase
  test "메시지 본문이 없는 경우 예외 발생" do
    assert_raise ArgumentError do
      SMS_API.send_SMS(dest_phone: "01022205736")
    end
  end

  test "수신자 전화번호가 없는 경우 예외 발생" do
    assert_raise ArgumentError do
      SMS_API.send_SMS(msg_body: "SMS TEST")
    end
  end

  test "발신자 전화번호가 없는 경우에는 정상적으로 발송" do
      SMS_API.send_SMS(msg_body: "SMS TEST", dest_phone: "01022205736")
  end
end
