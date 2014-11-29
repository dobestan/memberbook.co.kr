$('.profile').click(function(e) {
	$(e.currentTarget).toggleClass('backOn');
});

$('#navBar #elementUl').click(function(e) {
	var target = $(e.target);
	var tagName = target[0].tagName;

	// #LI element 선택
	if (tagName === 'UL') return;
	if (tagName === 'A') target = target.parent();
	if (tagName === 'I') target = target.parent().parent();

	// 기존 active element 포커싱 제거
	$(this).find('.active').toggleClass('active');
	target.toggleClass('active');
});

// 첫번째 그룹 포커싱 초기화
$('.group').eq(1).addClass('active');