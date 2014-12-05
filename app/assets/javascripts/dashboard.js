var LeftSidebar = {
	groupUl: $('#leftSidebar .groupUl'),
	selectAnotherGroup: function(e) {
		// li 요소 검색
		target = $(e.target).closest('li');

		var groupCode = target.data('code');
		var groupId = target.data('id');

		$.ajax({
			type: 'GET',
			url: '/dashboard/' + groupCode + '/' + groupId + '/users',
			success: function(data) {
				var userTemplate = $('#userTemplate');
				userTemplate = _.template(userTemplate.text());

				var profiles = "";
				var profile;

				// 메뉴 포커싱 변경
				$(this).find('.active').toggleClass('active');
				target.toggleClass('active');
				
				// 각 유저 당 탬플릿 생성
				$(data).each(function(idx, value) {
					profile = userTemplate({
						offsetClass: idx % 2 !== 0 ? 'col-sm-offset-1 col-md-offset-1' : '',
						name: value.name,
						grade: value.grade,
						phone_number: value.phone_number,
						email: value.email,
						address: value.address
					});

					profiles += profile;
				}.bind(this));

				// 기존 그룹 유저 하이드
				$('#profileUl .row').fadeOut(300, function() {
					$(this).children().remove();
					// 새 그룹 유저 돔에 추가
					$(profiles).appendTo($(this));
					$(this).fadeIn(300);
				});
			}.bind(this)
		});
	},
	init: function() {
		// 첫번째 그룹 포커싱 초기화
		this.groupUl.find('.group').eq(1).addClass('active');
		this.groupUl.click(this.selectAnotherGroup);
	}
};

LeftSidebar.init();

var User = {
	wrapper: $('#usersWrapper'),
	profileUl: $('#usersWrapper #profileUl'),
	toggleUserFace: function(e) {
		// li 요소 검색
		var target = $(e.target).closest('li');
		// 앞면 뒷면 토글
		$(target).toggleClass('backOn');
	},
	init: function() {
		this.profileUl.click(this.toggleUserFace);
	}
};

User.init();

var NavBar = {
	elementUl: $('#navBar #elementUl'),
	selectMenu: function(e) {
		// li 요소 검색
		var target = $(e.target).closest('li');

		if (target.is('li')) {
			// 포커싱 변경
			var preFocusedElement = $(this).find('.active');
			preFocusedElement.toggleClass('active');
			target.toggleClass('active');

			// 메인 컨텐츠 변경
			$('#' + preFocusedElement.data('wrapper')).fadeOut(300, function() {
				$('#' + target.data('wrapper')).fadeIn(300);
			});	
		}
	},
	init: function() {
		this.elementUl.click(this.selectMenu);
	}
};

NavBar.init();

var Setting = {
	wrapper: $('#settingsWrapper'),
	userTableWrapper: $('.userTableWrapper'),

	activateGroupEdit: function(e) {
		var ancestor = $(this).parent();
		var groups = ancestor.find('.group');
		var target = $(e.target);

		if (target.hasClass('editBtn')) {
			ancestor.toggleClass('edit');
		} else if (target.hasClass('saveBtn')) {
			ancestor.toggleClass('edit');
		} else {
			if (ancestor.hasClass('show')) {
				groups.fadeOut(300);
				ancestor.toggleClass('show');
				ancestor.removeClass('edit');
			} else {
				groups.fadeIn(300);
				ancestor.toggleClass('show');
			}
		}
	},
	addGroup: function(e) {
		var ancestor = $(this).closest('.ancestor');
		var groupLevel = ancestor.data('level');
		var groupCode = ancestor.data('code');
		var groupId = ancestor.data('id');
		// 그룹 이름
		var name = $(this).parent().find('input').val();

		$.ajax({
			type: 'POST',
			url: '/dashboard/' + groupCode + '/' + groupId + '/groups',
			data: {
				name: name,
				group_level: groupLevel
			},
			success: function(data) {
				// 그룹 탬플릿 생성
				var groupTemplate = $('#groupTemplate');
				groupTemplate = _.template(groupTemplate.text());

				// 그룹 생성
				var group = groupTemplate({
					level: data.level,
					id: data.id,
					code: data.code,
					name: data.name
				});

				// 돔 추가
				$(group).insertAfter(ancestor.find('.group').last());
			},
			error: function(msg) {
				alert('그룹추가를 실패했습니다');
			}
		});
	},
	deleteGroup: function(e) {
		var target = $(e.target);
		// minus 버튼이 아니라면
		var groupId = target.parent().data('id');

		$.ajax({
			type: 'DELETE',
			url: '/dashboard/groups/' + groupId,
			success: function(data) {
				target.parent().remove();
			},
			error: function(msg) {
				alert('그룹삭제를 실패했습니다');
			}
		});
	},
	activateTableUserEdit: function(e) {
		if ($(e.target).is('.btn')) {
			$(this).parents('.userTableWrapper').toggleClass('edit');	
		}
	},
	init: function() {
		this.wrapper.find('.ancestorContainer').click(this.activateGroupEdit);
		this.wrapper.find('.ancestor .plus').click(this.addGroup);
		this.wrapper.find('.ancestor .minus').click(this.deleteGroup);
		this.userTableWrapper.find('.btns').click(this.activateTableUserEdit);
	}
};

Setting.init();

$('.userTableWrapper .userTbodyWrapper').click(function(e) {
	var target = $(e.target);
	
	if (target.hasClass('minus')) {
		var userId = target.parents('tr').data('id');

		$.ajax({
			type: 'DELETE',
			url: '/dashboard/users/' + userId,
			success: function(data) {
				target.parents('tr').remove();
			},
			error: function(msg) {
				alert('그룹삭제를 실패했습니다');
			}
		});
	}
});

$('.userTableWrapper .plus').click(function(e) {
	var target = $(e.target);
	var addUserRow = target.parents('tr');
	var theadTable = target.parents('.theadTable');

	// 그룹 정보
	var groupCode = theadTable.data('code');
	// 유저 정보
	var name = addUserRow.find('.name input').val();
	var grade = addUserRow.find('.grade input').val();
	var groupId = addUserRow.find('.group select').val();
	var phoneNumber = addUserRow.find('.phoneNumber input').val();
	var email = addUserRow.find('.email input').val();
	var address = addUserRow.find('.address input').val();
	var birthday = addUserRow.find('.birthday input').val();
	$.ajax({
		type: 'POST',
		url: '/dashboard/' + groupCode + '/' + groupId + '/users',
		data: {
			name: name,
			grade: grade,
			phone_number: phoneNumber,
			email: email,
			address: address,
			birthday: birthday
		},
		success: function(data) {
			var userTemplateInTable = $('#userTemplateInTable');
			userTemplateInTable = _.template(userTemplateInTable.text());

			// 그룹 생성
			var user = userTemplateInTable({
				id: data.user.id,
				name: data.user.name,
				grade: data.user.grade,
				group: data.group.name,
				phone_number: data.user.phone_number,
				email: data.user.email,
				address: data.user.address,
				birthday: data.user.birthday
			});

			// 돔 추가
			$(user).appendTo(target.parents('.userTableWrapper').find('.userTbodyWrapper').find('tbody'));
		},
		error: function(msg) {
			alert('유저추가를 실패했습니다');
		}
	});
});

$('#boardForm').ckeditor();

$('#boardListRow #writeBtn').click(function(e) {
	var activeRow = $('#boardWrapper .row.active');
	var willBeActiveRow = $('#boardWrapper #writeBoardRow');

	activeRow.fadeOut(300, function() {
		$(this).toggleClass('active');
		willBeActiveRow.toggleClass('active');
		willBeActiveRow.fadeIn(300);
	});
});

$('#writeBoardRow .listBtn').click(function() {
	var activeRow = $('#boardWrapper .row.active');
	var willBeActiveRow = $('#boardWrapper #boardListRow');

	activeRow.fadeOut(300, function() {
		$(this).toggleClass('active');
		willBeActiveRow.toggleClass('active');
		willBeActiveRow.fadeIn(300);
	});
});

$('#writeBoardRow .saveBtn').click(function() {

});