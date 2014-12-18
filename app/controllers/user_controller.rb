class UserController < ApplicationController
  include MessagesHelper

  # GET /:group_id/users
  def users
    @group = Group.find_by! code: params[:group_code]
    @users = @group.descendents_users
    
    respond_to do |format|
      format.json { render json: @users }
    end
  end

  # POST /:group_code/:groud_id/groups
  # 학교 ( group_code ) 에 해당 그룹 ( group_id ) 의 서브그룹으로 추가
  def create
    @user = User.create({
      name: params[:name],
      phone_number: params[:phone_number],
      email: params[:email],
      grade: params[:grade],
      address: params[:address],
      birthday: params[:birthday]
    });

    @group = Group.find(params[:group_id])
    @group.users << @user

    respond_to do |format|
      if @user.save
        format.json { render json: {
            :user => @user,
            :group => @group
          }
        }
      else
        format.json { render plain: "fail" }
      end
    end
  end

  # DELETE /users/:user_id
  # group_id 에 해당 그룹 삭제
  def destroy
    @user = User.find(params[:user_id]);
    @user.destroy

    respond_to do |format|
      if @user.destroyed?
        format.json { render plain: "success" }
      else
        format.json { render plain: "fail" }
      end
    end
  end 

  def get_confirm_number
    dest_phone = params[:phone_number]

    authentification_number = (rand() * 1000000).to_i
    response = JSON.parse SMS_API.send_SMS(dest_phone: dest_phone, msg_body: "인증번호: #{authentification_number}")
    flash[:authentification_number] = authentification_number

    render plain: authentification_number
  end

  def confirm
    dest_phone = params[:phone_number]
    authentification_number_input = params[:authentification_number]
    authentification_number = flash[:authentification_number]
    puts "input auth num: #{authentification_number_input}"
    puts "real auth num: #{authentification_number}"
    puts "session[:hi]: #{session[:hi]}"
    
    if authentification_number_input.to_i == authentification_number
      render plain: "success"
    else
      render plain: "fail"
    end
  end
end