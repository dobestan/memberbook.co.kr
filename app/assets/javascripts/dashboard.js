var LoggedUser = {
	id: $('#userIdInput').val(),
	groupCode: $('#groupCodeInput').val(),
	groupId: $('#groupIdInput').val()
};

var LeftSidebar = {
	groupUl: $('#leftSidebar .groupUl'),
	selectAnotherGroup: function(e) {
		// li 요소 검색
		target = $(e.target).closest('li');

		var groupCode = target.data('code');
		var groupId = target.data('id');

		// 로그인된 유저가 현재 선택한 그룹 코드 설정
		LoggedUser.groupCode = target.data('code');
		LoggedUser.groupId = target.data('id');

		// 메뉴 포커싱 변경
		$(this).find('.active').toggleClass('active');
		target.toggleClass('active');

		var activeWrapperName = $('#navBar .element.active').data('wrapper');
		var activeWrapper = $('#' + activeWrapperName);
		NavBar.initFocus();
		activeWrapper.fadeOut(300, function() {
			UserManager.initWrapper($('#usersWrapper'));
		});
		// $.ajax({
		// 	type: 'GET',
		// 	url: '/' + groupCode + '/' + groupId + '/users.js',
		// 	dataType: 'text',
		// 	success: function(data) {
		// 		// var userTemplate = $('#userTemplate');
		// 		// userTemplate = _.template(userTemplate.text());

		// 		// var profiles = "";
		// 		// var profile;

		// 		// 메뉴 포커싱 변경
		// 		// $(this).find('.active').toggleClass('active');
		// 		// target.toggleClass('active');
				
		// 		// 로그인된 유저가 현재 선택한 그룹 코드 설정
		// 		// LoggedUser.groupCode = target.data('code');

		// 		// 각 유저 당 탬플릿 생성
		// 		// $(data).each(function(idx, value) {
		// 		// 	profile = userTemplate({
		// 		// 		offsetClass: idx % 2 !== 0 ? 'col-sm-offset-1 col-md-offset-1' : '',
		// 		// 		name: value.name,
		// 		// 		grade: value.grade,
		// 		// 		phone_number: value.phone_number,
		// 		// 		email: value.email,
		// 		// 		address: value.address
		// 		// 	});

		// 		// 	profiles += profile;
		// 		// }.bind(this));

		// 		// 기존 그룹 유저 하이드
		// 		// $('#profileUl .row').fadeOut(300, function() {
		// 		// 	$(this).children().remove();
		// 		// 	// 새 그룹 유저 돔에 추가
		// 		// 	$(profiles).appendTo($(this));
		// 		// 	$(this).fadeIn(300);
		// 		// });

					
		// 	}.bind(this)
		// });
	},
	init: function() {
		// 첫번째 그룹 포커싱 초기화
		var firstGroup = this.groupUl.find('.group').eq(1);
		firstGroup.addClass('active');
		// 로그인된 유저가 현재 선택한 그룹 코드 설정
		LoggedUser.groupCode = firstGroup.data('code');
		this.groupUl.click(this.selectAnotherGroup);
	}
};

LeftSidebar.init();

var UserManager = {
	wrapper: $('#usersWrapper'),
	profileUl: $('#usersWrapper #profileUl'),
	toggleUserFace: function(e) {
		// li 요소 검색
		var target = $(e.target).closest('li');
		// 앞면 뒷면 토글
		$(target).toggleClass('backOn');
	},
	initWrapper: function(wrapper) {
		var groupCode = LoggedUser.groupCode;
		var groupId = LoggedUser.groupId;
		debugger;
		$.ajax({
			type: 'GET',
			url: '/' + groupCode + '/' + groupId + '/users.js',
			dataType: 'text',
			success: function(data) {
				this.wrapper.html($(data));
				wrapper.fadeIn(300);
			}.bind(this),
			error: function(msg) {
				alert(msg);
			}
		});
	},
	init: function() {
		this.profileUl.click(this.toggleUserFace);
	}
};

UserManager.init();

var GroupInfoManager = {
	wrapper: $('#groupInfoWrapper'),
	initWrapper: function(wrapper) {
		wrapper.fadeIn(300);
	}
};

var SettingsManager = {
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
			url: '/' + groupCode + '/' + groupId + '/groups',
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
		if (target.is('.minus')) {
			var groupId = target.parent().data('id');

			$.ajax({
				type: 'DELETE',
				url: '/groups/' + groupId,
				success: function(data) {
					target.parent().remove();
				},
				error: function(msg) {
					alert('그룹삭제를 실패했습니다');
				}
			});
		}
	},
	activateTableUserEdit: function(e) {
		if ($(e.target).is('.btn')) {
			$(this).parents('.userTableWrapper').toggleClass('edit');	
		}
	},
	initWrapper: function(wrapper) {
		wrapper.fadeIn(300);
	},
	init: function() {
		this.wrapper.find('.ancestorContainer').click(this.activateGroupEdit);
		this.wrapper.find('.ancestor .plus').click(this.addGroup);
		this.wrapper.find('.ancestor').click(this.deleteGroup);
		this.userTableWrapper.find('.btns').click(this.activateTableUserEdit);
	}
};

SettingsManager.init();

$('.userTableWrapper .userTbodyWrapper').click(function(e) {
	var target = $(e.target);
	
	if (target.hasClass('minus')) {
		var userId = target.parents('tr').data('id');

		$.ajax({
			type: 'DELETE',
			url: '/users/' + userId,
			success: function(data) {
				target.parents('tr').remove();
			},
			error: function(msg) {
				alert('유저삭제를 실패했습니다');
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
		url: '/' + groupCode + '/' + groupId + '/users',
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

var BoardManager = {
	wrapper: $('#boardsWrapper'),
	boardListRow: $('#boardsWrapper #boardListRow'),
	writeBoardRow: $('#boardsWrapper #writeBoardRow'),
	showBoardRow: $('#boardsWrapper #showBoardRow'),
	form: $('#boardForm'),
	editor: '',
	// 글쓰기 뷰 전환
	changeRow: function(e) {
		var target = $(e.target);
		var activeRow = $('#boardsWrapper .row.active');
		var willBeActiveRow = $('#' + target.data('row'));

		if (target.is('.btn')) {
			activeRow.fadeOut(300, function() {
				$(this).toggleClass('active');
				willBeActiveRow.toggleClass('active');
				willBeActiveRow.fadeIn(300);
			});
		}
	},
	reloadList: function(data) {
		var activeRow = this.wrapper.find('.row.active');
		activeRow.fadeOut(300, function() {
			activeRow.toggleClass('active');
			this.wrapper.hide();
			// boardList 보이기
			this.boardListRow.show();
			this.boardListRow.toggleClass('active');
			// 새로 rendering 한 partial 추가
			$('#boardsWrapper #boardListRow').html(data);
			this.addBoardListRowEvent();
			this.wrapper.fadeIn(300);
		}.bind(this));
	},
	add: function(e) {
		var selectedGorupCode = LoggedUser.groupCode;
		var userId = LoggedUser.id;
		var title = this.form.find('#titleInput').val();
		var content = this.editor.getData();

		$.ajax({
			type: 'POST',
			url: '/' + selectedGorupCode + '/boards.js',
			dataType: 'text',
			data: {
				user_id: userId,
				title: title,
				content: content,
				level: 0
			},
			success: function(data) {
				this.form[0].reset();
				this.editor.setData('');
				this.reloadList(data);
			}.bind(this),
			error: function() {
				alert('글쓰기를 실패했습니다');
			}
		});
	},
	changePage: function(e) {
		target = $(e.target);

		if (target[0].tagName !== 'A') return;
		
		var val = target.text();
		// 숫자를 눌렀다면
		if ($.isNumeric(val)) {
			var groupCode = LoggedUser.groupCode;
			$.ajax({
				type: 'GET',
				url: '/' + groupCode + '/boards.js',
				dataType: 'text',
				data: {
					page_num: val
				},
				success: function(data) {
					this.reloadList(data);
				}.bind(this),
				error: function(msg) {
					alert(msg);
				}
			});	
		// 화살표를 눌렀다면
		} else {
			debugger;
		}
	},
	show: function(e) {
		var target = $(e.target);
		var boardId = target.prev().text();
		var groupCode = LoggedUser.groupCode;

		$.ajax({
			type: 'GET',
			url: '/' + groupCode + '/boards/' + boardId,
			success: function(data) {
				var activeRow = this.wrapper.find('.row.active');
				activeRow.fadeOut(300, function() {
					activeRow.toggleClass('active');
					this.showBoardRow.toggleClass('active');
					this.showBoardRow.find('.title h3').text(data.title);
					this.showBoardRow.find('.content').html(data.content);
					this.showBoardRow.fadeIn(300);
				}.bind(this));
			}.bind(this),
			error: function(msg) {

			}
		});
	},
	addBoardListRowEvent: function() {
		this.wrapper.find('.writeBtn').click(this.changeRow);
		this.wrapper.find('#boardPageNumUl').click(this.changePage.bind(this));
		this.wrapper.find('#boardListRow table').click(this.show.bind(this));
	},
	getBoardList: function(e) {
		var groupCode = LoggedUser.groupCode;
		var pageNum = this.boardListRow.find('.boardPageNum.active').text();
		$.ajax({
			type: 'GET',
			url: groupCode + '/boards.js',
			dataType: 'text',
			data: {
				page_num: pageNum
			},
			success: function(data) {
				this.reloadList(data);
			}.bind(this),
			error: function(msg) {
				alert(msg);
			}
		});
	},
	initWrapper: function(wrapper) {
		var groupCode = LoggedUser.groupCode;
		var pageNum = 1;

		$.ajax({
			type: 'GET',
			url: '/' + groupCode + '/boards.js',
			dataType: 'text',
			data: {
				page_num: pageNum
			},
			success: function(data) {
				$('#boardsWrapper #boardListRow').html(data);
				BoardManager.addBoardListRowEvent();
				wrapper.fadeIn(300);
			}.bind(this),
			error: function(msg) {
				alert(msg);
			}
		});
	},
	init: function() {
		this.form.find('textarea').ckeditor();
		this.editor = CKEDITOR.instances.editor1;
		this.addBoardListRowEvent();
		this.wrapper.find('.listBtn').click(this.getBoardList.bind(this));
		this.wrapper.find('.saveBtn').click(this.add.bind(this));
	}
};

BoardManager.init();

WrapperManager = {
	wrappers: $('.wrapper'),
	usersWrapper: UserManager,
	groupInfoWrapper: GroupInfoManager,
	boardsWrapper: BoardManager,
	settingsWrapper: SettingsManager
};

var NavBar = {
	wrapperManager: WrapperManager,
	elementUl: $('#navBar #elementUl'),
	selectMenu: function(e) {
		if (this.wrapperManager.wrappers.is(':animated')) return;
		// li 요소 검색
		var target = $(e.target).closest('li');

		if (target.is('li')) {
			// 포커싱 변경
			var preFocusedElement = this.elementUl.find('.active');
			preFocusedElement.toggleClass('active');
			target.toggleClass('active');
			debugger;
			// 메인 컨텐츠 변경
			$('#' + preFocusedElement.data('wrapper')).fadeOut(300, function() {
				var wrapper = target.data('wrapper')
				debugger;
				this.wrapperManager[wrapper].initWrapper($('#' + wrapper));
			}.bind(this));
		}
	},
	initFocus: function() {
		var preFocusedElement = this.elementUl.find('.active');
		preFocusedElement.toggleClass('active');
		// debugger;
		this.elementUl.children().first().toggleClass('active');
		// debugger;
	},
	init: function() {
		this.elementUl.click(this.selectMenu.bind(this));
	}
};

NavBar.init();