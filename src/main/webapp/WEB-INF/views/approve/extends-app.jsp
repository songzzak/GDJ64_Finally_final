<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />


<jsp:include page="/WEB-INF/views/common/header.jsp" />


<link rel="stylesheet"
	href="${path}/resources/css/approve/drafting_app.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	
	<form action="#" id="appForm" method="post" enctype="multipart/form-data">
	
	<div class="approve-section section-shadow">
		<div id="approve_name">기안서신청</div>

		<div>
			<div id="one-width">
				<div id="kind">연장근무신청서</div>
				<div id="app-line" class="answer"></div>
			</div>

			<div id="one-width">
				<div id="department" class="question">부서</div>
				<div id="department-answer" class="answer">${loginMember.dept.deptName}</div>
				<div id="writer" class="question">기안자</div>
				<div id="writer-answer" class="answer">${loginMember.memberName}</div>
				<div id="position" class="question">직책</div>
				<div id="position-answer" class="answer">${loginMember.job.jobName}</div>
			</div>
			
			<input type="hidden" name="memberId" value="${loginMember.memberId}">
			<input type="hidden" name="approveKind" value="연장근무신청서">
			
			<div id="one-width">
				<div id="extendWorkWriteDate" class="question">작성일</div>
				<div id="extendWorkWriteDate-answer" class="answer" name="writeTime">${time}</div>
			</div>
			
			<div id="one-width">
				<div id="extendWork" class="question">근무일시</div>
				<div id="extendWork-answer" class="answer">
					<input type="date" id="extendWorkDate-input" name="extendWorkDate">
					<input type="time" id="extendWorkTime1-input" name="startTime">
					<span id="betweenTime">~</span>
					<input type="time" id="extendWorkTime2-input" name="endTime">
				</div>
			</div>
	
			<div id="one-width">
				<div id="extendTimeTitle" class="question">제목</div>
				<div id="extendTimeTitle-answer" class="answer">
					<input type="text" id="title-input" name="title">
				</div>
			</div>
			
			<div id="one-width">
				<div id="content" class="question">신청사유</div>
				<div id="content-answer" class="answer">
					<textarea id="content-textarea" name="content"></textarea>
				</div>
			</div>

			<div id="one-width">
				<div id="appAttachment" class="question">첨부파일</div>
				<div id="appAttachment-answer" class="answer">
					<input type="file" id="appAttachment-input" name="upFile">
				</div>
			</div>

			<div id="one-width">
				<button type="button" onclick="backs();" id="back">돌아가기</button>
				<button type="button" onclick="saves();" id="save">임시저장</button>
				<button type="button" onclick="signs();" id="sign">결재상신</button>
			</div>

		</div>
	</div> 
	
<jsp:include page="/WEB-INF/views/approve/approval-ref.jsp"/>

</form> 
</html>	

<script>
	const backs=()=>{
		location.assign("${path}/");
	}
	
	const saves=()=>{
		
	}
	
	const signs=()=>{

		if(document.getElementById("title-input").value == "" || document.getElementById("content-textarea").value == ""){
			alert("제목 내용 입력");
			return false;
		}
		
		if(document.getElementById("extendWorkDate-input").value == "" || document.getElementById("extendWorkTime1-input").value == "" ||
				document.getElementById("extendWorkTime2-input").value == ""){
			alert("시간입력");
			return false;
		}
		
 		$("#appForm").attr("action","${path}/approve/insertDraft.do"); 
		$("#appForm").submit(); 
		
	}
	
</script>


