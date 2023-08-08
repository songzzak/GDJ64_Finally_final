//주소 검색 메소드
function fn_searchAddr() {
	//주소 API 사용
	new daum.Postcode({
		oncomplete: function(data) {
			$("#main-addr").val(data.address);
			$("#detail-addr").focus();
		}
	}).open();
}

//데이터 입력 확인 후 넘기는 메소드
function fn_empDataCk() {
	$("#enroll-form").submit();
}