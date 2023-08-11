<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="approveNo" value="${approveNo}"/>

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
					<input type="date" id="extendWorkDate-input" name="startDate" value="${date}">
					<%-- value="${saveExtends[0].time.startTime.toLocalDateTime().getYear()}${'-0'}${saveExtends[0].time.startTime.toLocalDateTime().getMonthValue()}${'-'}${saveExtends[0].time.startTime.toLocalDateTime().getDayOfMonth()} --%>
					
					<input type="time" id="extendWorkTime1-input" name="startTime" value="${stime}">
					<span id="betweenTime">~</span>
					<input type="time" id="extendWorkTime2-input" name="endTime" value="${etime}">
				</div>
			</div>
	
			<div id="one-width">
				<div id="extendTimeTitle" class="question">제목</div>
				<div id="extendTimeTitle-answer" class="answer">
					<input type="text" id="title-input" name="title" value="${saveExtends[0].approveTitle}">
				</div>
			</div>
			
			<div id="one-width">
				<div id="content" class="question">신청사유</div>
				<div id="content-answer" class="answer">
					<textarea id="content-textarea" name="content">${saveExtends[0].approveContent}</textarea>
				</div>
			</div>

			<div id="one-width">
				<div id="appAttachment" class="question">첨부파일</div>
				<div id="appAttachment-answer" class="answer">
					<input type="file" id="appAttachment-input" name="upFile" value="${saveExtends[0].approveAttach.oriName}">
				</div>
			</div>
			
			<c:choose>
				<c:when test="${saveExtends[0].approveState eq '임시저장'}">
					<div id="one-width">
						<button type="button" onclick="remove();" id="remove">삭제하기</button>
						<button type="button" onclick="saves();" id="save">임시저장</button>
						<button type="button" onclick="signs();" id="sign">결재상신</button>
					</div>
				</c:when>
				<c:otherwise>
					<div id="one-width">
						<button type="button" onclick="backs();" id="back">돌아가기</button>
						<button type="button" onclick="saves();" id="save">임시저장</button>
						<button type="button" onclick="signs();" id="sign">결재상신</button>
					</div>
				</c:otherwise>
			</c:choose>
			
		</div>
	</div> 
	
<jsp:include page="/WEB-INF/views/approve/approval-ref.jsp"/>

</form> 
</html>	

<script>
	$(function() {	
		const approveLines=JSON.parse('${approveLines}'); // 자바스크립트에서 해당 JSON.parse 구문을통해 해당 값을 객체로 반환
		const referLines=JSON.parse('${referLines}'); 

		console.log(approveLines);
		console.log(referLines);

/* 		approvLines.forEach(e=>{
			
		}); */
		
		for(let i=0; i<approveLines.length; i++){
			const span = $("<span>");
			span.attr("class", "appClass");
			$("#regist-app").append(span);
			span.append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
			span.append(approveLines[i].memberId.memberId + " " + approveLines[i].memberId.memberName + " " + approveLines[i].memberId.job.jobName + " " + approveLines[i].memberId.dept.deptName, '<br>');
			span.append($("<input/>", { type: 'hidden', name: 'paraApp', value: approveLines[i].memberId.memberId }));
			const di = $("<div>").css("border", "1px solid black").height("98px").width("120px");
			$("#app-line").append(di);
			di.append($("<div>").css("border-bottom", "1px solid black").height("30px").width("120px").text(approveLines[i].memberId.memberName + " " + approveLines[i].memberId.job.jobName).css("text-align","center"));
			di.append($("<div>").height("40px").width("120px"));
			di.append($("<div>").css("border-top", "1px solid black").height("28px").width("120px").text(i+1).css("text-align","center"));
		}
		
		for(let i=0; i<referLines.length; i++){
			const span = $("<span>");
			span.attr("class", "appId");
			$("#regist-reference").append(span);
			span.append($('<img/>',{src:path+'/resources/images/approve/circle_people.png',width:'20px',height:'20px'}));
			span.append(referLines[i].memberId.memberId + " " + referLines[i].memberId.memberName + " " + referLines[i].memberId.job.jobName + " " + referLines[i].memberId.dept.deptName, '<br>');
			span.append($("<input/>", { type: 'hidden', name: 'paraRefer', value: referLines[i].memberId.memberId })); // 파라미터로넘길 참조선값들		
		}
		
		
	});
	
	const remove=()=>{
		location.assign("${path}/approve/removeSave.do?deleteApproveNo=${approveNo}"); 
	}
	

	const backs=()=>{
		location.assign("${path}/");
	}
	
	const saves=()=>{
		if(document.getElementById("extendWorkDate-input").value == "" || document.getElementById("extendWorkTime1-input").value == "" ||
				document.getElementById("extendWorkTime2-input").value == ""){
			
/* 			if(document.getElementById("extendWorkDate-input").value == "" && document.getElementById("extendWorkTime1-input").value == "" 
					&& document.getElementById("extendWorkTime2-input").value == ""){
			}else{
				alert("시간입력");
				return false;				
			}	 */	
			alert("시간입력");
			return false;	
		}
		
 		$("#appForm").attr("action","${path}/approve/saveExtends.do"); 
		$("#appForm").submit(); 
	}
	
	const signs=()=>{

		if($(".appClass").length < 1){
			alert("결재선에 최소 한명이상 선택하세요");
			return false;
		}
		
		if($(".appId").length < 1){
			alert("참조선에 최소 한명이상 선택하세요");
			return false;
		}
					
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


