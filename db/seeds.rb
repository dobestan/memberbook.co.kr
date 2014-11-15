# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# t.string :name
#     	t.string :phone_number
#     	t.string :email
#     	t.string :profile_img_name
#     	t.string :grade
#     	t.string :address
#     	t.date :birthday

case Rails.env
when "development"
	users = User.create([{
			name: '현제혁',
			phone_number: '010-3321-3748',
			email: 'hook3748@gmail.com',
			profile_img_name: 'profile.png',
			grade: '3학년',
			address: '서울시 서대문구 연희동 316-1번지',
			birthday: '1992-11-01'
		}, {
			name: '안수찬',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 봉천동',
			birthday: '1993-5-1'
			}]);
when "production"
end