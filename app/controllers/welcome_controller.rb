class WelcomeController < ApplicationController
	require 'csv'

  def index
  end

  def about
  end

  def login
  end

  def upload_data
  	# group = Group.find(parmas[:group_id])
  	CSV.foreach('test/users_sub.csv', headers: true) do |row|
      user = User.create row.to_hash
      # user.save
      puts user.inspect
    end
  end
end
