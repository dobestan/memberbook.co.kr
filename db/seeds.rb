# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

case Rails.env
when "development"
	emba_users = User.create([{
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}])

	art_users = User.create([{
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}, {
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}, {
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}, {
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}])
	# 성균관대 EMBA
	emba_groups = Group.create([{
			name: '성균관대 EBMA',
			level: 0,
			code: 0,
			point: 50000
		}, {
			name: '건설경영',
			point: 10000,
			level: 1,
			code: 0,
			parent_id: 1
		}, {
			name: '건설사업관리',
			point: 25000,
			level: 1,
			code: 0,
			parent_id: 1
		}, {
			name: '건축공간환경디자인',
			point: 5000,
			level: 1,
			code: 0,
			parent_id: 1
		}, {
			name: '건축도시디자인',
			point: 12000,
			level: 1,
			code: 0,
			parent_id: 1
		}, {
			name: '그린빌딩시스템',
			point: 18000,
			level: 1,
			code: 0,
			parent_id: 1
		}])

	# 중앙대 예술대학원
	art_groups = Group.create([{
			name: '중앙대 예술대학원',
			level: 0,
			code: 1,
			point: 50000
		}, {
			name: '산업디자인',
			level: 1,
			point: 20000,
			code: 1,
			parent_id: 7
		}])

	# 그룹 유저 간 의존 생성
	# 유저 현제혁은 'EMBA의 건설 경영' 과 '중앙대 예술대학교의 산업디자인' 총 2개 그룹에 속함
	emba_groups[1].users << emba_users

	art_groups[1].users << emba_users[0]
	art_groups[1].users << art_users

	emba_boards = Board.create([{
			writer: emba_users[0].name,
			title: 'EMBA 원우수첩 런칭!',
			content: '<h1> EMBA 원우수첩 런칭 했습니다.</h1>',
			count: 0,
			level: 0,
			group_id: 1
		}, {
			writer: emba_users[0].name,
			title: '안녕하세요 관리자입니다.',
			content: '<h1> EMBA 원우수첩 런칭 했습니다.</h1><hr><i>많은 이용 바랍니다.</i>',
			count: 0,
			level: 0,
			group_id: 1
		}])
when "production"
	emba_users = []

	(1..500).each do |idx|
		emba_users.concat(User.create([{
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
		}]))
	end

	art_users = User.create([{
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}, {
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}, {
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}, {
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
		}, {
			name: '김민혁',
			phone_number: '010-2220-5736',
			email: 'dobestan@gmail.com',
			profile_img_name: 'suchan.png',
			grade: '2학년',
			address: '서울시 관악구 낙성대동',
			birthday: '1992-3-1'
		}])
	# 성균관대 EMBA
	emba_groups = Group.create([{
			name: '성균관대 EBMA',
			level: 0,
			code: 0,
			point: 50000
		}, {
			name: '건설경영',
			point: 10000,
			level: 1,
			code: 0,
			parent_id: 1
		}, {
			name: '건설사업관리',
			point: 25000,
			level: 1,
			code: 0,
			parent_id: 1
		}, {
			name: '건축공간환경디자인',
			point: 5000,
			level: 1,
			code: 0,
			parent_id: 1
		}, {
			name: '건축도시디자인',
			point: 12000,
			level: 1,
			code: 0,
			parent_id: 1
		}, {
			name: '그린빌딩시스템',
			point: 18000,
			level: 1,
			code: 0,
			parent_id: 1
		}])

	# 중앙대 예술대학원
	art_groups = Group.create([{
			name: '중앙대 예술대학원',
			level: 0,
			code: 1,
			point: 50000
		}, {
			name: '산업디자인',
			level: 1,
			point: 20000,
			code: 1,
			parent_id: 7
		}])

	# 그룹 유저 간 의존 생성
	# 유저 현제혁은 'EMBA의 건설 경영' 과 '중앙대 예술대학교의 산업디자인' 총 2개 그룹에 속함
	emba_groups[1].users << emba_users

	art_groups[1].users << emba_users[0]
	art_groups[1].users << art_users

	emba_boards = Board.create([{
			writer: emba_users[0].name,
			title: 'EMBA 원우수첩 런칭!',
			content: '<h1> EMBA 원우수첩 런칭 했습니다.</h1>',
			count: 0,
			level: 0,
			group_id: 1
		}, {
			writer: emba_users[0].name,
			title: '안녕하세요 관리자입니다.',
			content: '<h1> EMBA 원우수첩 런칭 했습니다.</h1><hr><i>많은 이용 바랍니다.</i>',
			count: 0,
			level: 0,
			group_id: 1
		}])
end