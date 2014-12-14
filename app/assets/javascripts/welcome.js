$('#phoneNumberBtn').click(function(e) {
	e.preventDefault();
	var phoneNumber = $(e.target).prev().val();

	$.ajax({
		type: 'GET',
		url: 'get_confirm_number',
		data: {
			phone_number: phoneNumber
		},
		success: function(data) {
			debugger;
		},
		error: function(msg) {
			alert(msg);
		}
	});
});

$('#confirmBtn').click(function(e) {
	e.preventDefault();
	var phoneNumber = $(e.target).parent().children().first().val()
	var authentificationNumber = $(e.target).prev().val();
	$.ajax({
		type: 'POST',
		url: 'confirm',
		data: {
			phone_number: phoneNumber,
			authentification_number: authentificationNumber
		},
		success: function(data) {
			debugger;
		},
		error: function(msg) {
			alert(msg);
		}
	});
});