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

	<form action="#" id="appForm" method="post"
		enctype="multipart/form-data">

		<div class="approve-section section-shadow">
			<div id="approve_name">기안서신청</div>

			<div>
				<div id="one-width">
					<div id="kind">근태신청서</div>
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

				<div id="one-width">
					<div id="attendance-kind" class="question">종류</div>
					<div id="div-annual" class="answer">
						연차<input type="radio" id="annual" name="geuntae" value="연차">
					</div>
					<div id="div-halfAnuual" class="answer">
						반차<input type="radio" id="halfAnuual" name="geuntae" value="반차">
					</div>
					<div id="div-health" class="answer">
						보건<input type="radio" id="health" name="geuntae" value="보건">
					</div>
					<div id="div-condolences" class="answer">
						경조<input type="radio" id="condolences" name="geuntae" value="경조">
					</div>
					<div id="div-outing" class="answer">
						외출<input type="radio" id="outing" name="geuntae" value="외출">
					</div>
				</div>


				<div id="one-width">
					<div id="extendWorkWriteDate" class="question">작성일</div>
					<div id="extendWorkWriteDate-answer" class="answer" name="writeTime">${time}</div>
				</div>


				<div id="one-width">
					<div id="applicationDate" class="question">신청일</div>
					<div id="applicationDate-answer" class="answer">
						<input type="date" id="gStartDate" name="startDate"> <span
							id="gBetweenTime">~</span> <input type="date" id="gEndDate"
							name="endDate">
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

<jsp:include page="/WEB-INF/views/approve/approval-ref.jsp" />
</form> 
</html>

<script>

	$(function() {  // 레디함수
	    $("input:radio[name=geuntae]").click(function(){  // 연차, 보건, 경조는 날짜로만 선택
	    	if(this.id=="annual" || this.id=="health" || this.id=="condolences"){
	    		$("#applicationDate-answer").empty();
	    		$("#applicationDate-answer").append($('<input/>',{type:'date', name: 'startDate', id:'gStartDate'}));
	    		$("#applicationDate-answer").append($('<span/>',{id:'gBetweenTime'}));
	    		$("#gBetweenTime").text("~");
	    		$("#applicationDate-answer").append($('<input/>',{type:'date', name: 'endDate', id:'gEndDate'}));
	    	}
	    	
	    	if(this.id=="halfAnuual" || this.id=="outing"){ // 반차, 외출일경우 해당 날의 시간선택
	    		$("#applicationDate-answer").empty();
	    		$("#applicationDate-answer").append($('<input/>',{type:'date', name: 'startDate', id:'hStartDate'}));
	    		$("#applicationDate-answer").append($('<input/>',{type:'time', name: 'startTime', id:'hStartTime'}));
	    		$("#applicationDate-answer").append($('<span/>',{id:'hBetweenTime'}));
	    		$("#hBetweenTime").text("~");
	    		$("#applicationDate-answer").append($('<input/>',{type:'time', name: 'endTime', id:'hEndTime'}));
	    	}
	    	
	   	})
	});



	const backs=()=>{
		location.assign("${path}/");
	}
	
	const saves=()=>{
		
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
				
		if( $("input:radio[name='geuntae']:checked").length == 0){
			alert("종류를 선택하세요");
			return false;
		}
				
				
		if(document.getElementById("title-input").value == "" || document.getElementById("content-textarea").value == ""){
			alert("제목 내용 입력");
			return false;
		}
		
		const kind = $("input:radio[name='geuntae']:checked").val();
		
		if(kind == "반차" || kind == "외출"){
			if(document.getElementById("hStartDate").value == "" || document.getElementById("hStartTime").value == "" ||
					document.getElementById("hEndTime").value == ""){
				alert("시간입력");
				return false;
			}
		}else{  // 연차, 보건, 경조 경우
			if(document.getElementById("gStartDate").value == "" || document.getElementById("gEndDate").value == ""){
				alert("시간입력");
				return false;
			}
		}

 		$("#appForm").attr("action","${path}/approve/insertDraft.do"); 
		$("#appForm").submit(); 
		
	}
	
</script>