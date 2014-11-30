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
	// 기존 active element 포커싱 제거
	$(this).find('.active').toggleClass('active');
	target.toggleClass('active');
});

// 첫번째 그룹 포커싱 초기화
$('.group').eq(1).addClass('active');

$('#groupUl').click(function(e) {
	// li 요소 검색
	target = $(e.target).closest('li');
	// li 가 아니라면 리턴
	if (target[0].tagName !== 'LI') return;

	var code = target.data('code');
	var groupId = target.data('id');

	$.ajax({
		type: 'GET',
		url: '/dashboard/' + code + '/' + groupId + '/users',
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