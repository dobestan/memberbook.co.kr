$('#profileUl').click(function(e) {
	// li 요소 검색
	var target = $(e.target).closest('li');
	$(target).toggleClass('backOn');
});

$('#navBar #elementUl').click(function(e) {
	// li 요소 검색
	var target = $(e.target).closest('li');
	// li 가 아니라면 리턴
	if (target[0].tagName !== 'LI') return;
	// 포커싱 변경
	var preFocusedElement = $(this).find('.active');
	preFocusedElement.toggleClass('active');
	target.toggleClass('active');

	// 메인 컨텐츠 변경
	$('#' + preFocusedElement.data('wrapper')).fadeOut(300, function() {
		$('#' + target.data('wrapper')).fadeIn(300);
	})
});

// 첫번째 그룹 포커싱 초기화
$('.group').eq(1).addClass('active');

$('#groupUl').click(function(e) {
	// li 요소 검색
	target = $(e.target).closest('li');
	// li 가 아니라면 리턴
	if (target[0].tagName !== 'LI') return;

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
});

$('#settingsWrapper .ancestorContainer').click(function(e) {
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
});

$('#settingsWrapper .plus').click(function(e) {
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
			var groupTemplate = $('#groupTemplate');
			groupTemplate = _.template(groupTemplate.text());

			var group = groupTemplate({
				level: data.level,
				id: data.id,
				code: data.code,
				name: data.name
			});

			$(group).insertAfter(ancestor.find('.group').last());
		},
		error: function(msg) {
			debugger;
		}
	});
});

$('#settingsWrapper #groupUl').click(function(e) {
	var target = $(e.target);
	// minus 버튼이 아니라면
	if (!target.hasClass('minus')) return;

	var groupId = target.parent().data('id');

	$.ajax({
		type: 'DELETE',
		url: '/dashboard/groups/' + groupId,
		success: function(data) {
			target.parent().remove();
		},
		error: function(msg) {
			debugger;
		}
	});
});