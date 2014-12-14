class WelcomeController < ApplicationController
	include MessagesHelper

  def index
  end

  def about
  end

  def login
  	# flash[:authentification_number] = nil
  end

  def get_confirm_number
  	dest_phone = params[:phone_number]

  	authentification_number = 1592
  	# response = JSON.parse SMS_API.send_SMS(dest_phone: dest_phone, msg_body: "메세지 테스트입니다.")
  	flash[:authentification_number] = authentification_number
  	session[:hi] = "hi?"
    respond_to do |format|
			format.json { render plain: 1592 }
		end
  end

  def confirm
  	dest_phone = params[:phone_number]
  	authentification_number_input = params[:authentification_number]
  	authentification_number = flash[:authentification_number]
  	puts "input auth num: #{authentification_number_input}"
  	puts "real auth num: #{authentification_number}"
  	puts "session[:hi]: #{session[:hi]}"
  	
  	respond_to do |format|
  		format.json { render plain: "success?"}
  	end
  end
end
