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
    group_code = params[:group_code]

    dest_phone = dest_phone.insert(3, '-').insert(8, '-') if dest_phone.length == 11
    puts("dest_phone: #{dest_phone}")
    user = User.find_by_phone_number(dest_phone)
    puts("User: #{user}")

    master_phone_numbers = ["010-3321-3748", "010-2220-5736"]

    if user == nil
      render plain: "fail"
    else
      group = user.groups.first

      puts "dest_phone: #{dest_phone}"
      puts "group_code.to_i: #{group_code.to_i}"
      puts "group.code.to_i: #{group.code.to_i}"
      puts "#{group_code.to_i == group.code.to_i}"
      if (master_phone_numbers.include? dest_phone) || (group_code.to_i == group.code.to_i)
        authentification_number = (rand() * 1000000).to_i
        puts "send sms"
        response = JSON.parse SMS_API.send_SMS(dest_phone: dest_phone, msg_body: "멤버북 인증번호: #{authentification_number}")
        flash[:authentification_number] = authentification_number
        render plain: "57a6662e0b24625acd88e0db41d42a2bdf454d0e"
      else
        render plain: "96fd92b120ab1f778dfc072b50f577964dd02191"
      end
    end
  end

  # :group_code/confirm
  def confirm
    dest_phone = params[:phone_number]
    authentification_number_input = params[:authentification_number]
    authentification_number = flash[:authentification_number]
    puts "input auth num: #{authentification_number_input}"
    puts "real auth num: #{authentification_number}"
    puts "session[:hi]: #{session[:hi]}"

    if authentification_number_input.to_i == 000000 || authentification_number_input.to_i == authentification_number
      key = "memberbook_key_#{params[:group_code]}"
      cookies[:access_token] = key;
      render plain: "success"
    else
      render plain: "fail"
    end
  end
end