<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 스마트 에디터 스크립트 로드 -->
<script type="text/javascript" src="/resources/smarteditor/js/HuskyEZCreator.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div id="smarteditor">
        <textarea id="editorTxt" name="editorTxt" rows="20" cols="10" style="width: 90%"></textarea>
    </div>


<script>
var oEditors = [];

function smartEditor() {
	nhn.husky.EZCreator.createInIFrame({
	    oAppRef: oEditors,
	    elPlaceHolder: "editorTxt",
	    sSkinURI: "/resources/smarteditor/SmartEditor2Skin.html",
	    fCreator: "createSEditor2",
	    htParams : { 
	    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
	        bUseToolbar : true, 
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseVerticalResizer : false, 
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseModeChanger : false 
	    }
	});	
}


$(document).ready(function() {
	// 스마트 에디터 초기화
	smartEditor();
});

</script>

</body>
</html>
