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
				<div id="kind">지출결의서</div>
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
						
			<div id="one-width">
				<div id="extendWorkWriteDate" class="question">작성일</div>
				<div id="extendWorkWriteDate-answer" class="answer">${time}</div>
			</div>
			
			<input type="hidden" name="memberId" value="${loginMember.memberId}">
			<input type="hidden" name="approveKind" value="지출결의서">
			
			<div id="one-width">
				<div id="account" class="question">거래처</div>
				<div id="use-history" class="question">사용내역 및 용도</div>
				<div id="price" class="question">금액</div>
			</div>
			<div id="one-width">
					<input type="text" id="account0" name="account"  class="answer">
					<input type="text" id="use-history0" name="useHistory"  class="answer">
					<input type="text" id="price0" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account1" name="account"  class="answer">
					<input type="text" id="use-history1" name="useHistory"  class="answer">
					<input type="text" id="price1" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account2" name="account"  class="answer">
					<input type="text" id="use-history2" name="useHistory"  class="answer">
					<input type="text" id="price2" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account3" name="account"  class="answer">
					<input type="text" id="use-history3" name="useHistory"  class="answer">
					<input type="text" id="price3" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account4" name="account"  class="answer">
					<input type="text" id="use-history4" name="useHistory"  class="answer">
					<input type="text" id="price4" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account5" name="account"  class="answer">
					<input type="text" id="use-history5" name="useHistory"  class="answer">
					<input type="text" id="price5" name="price"  class="answer">
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

		if($(".appClass").length < 1){
			alert("결재선에 최소 한명이상 선택하세요");
			return false;
		}
		
		if($(".appId").length < 1){
			alert("참조선에 최소 한명이상 선택하세요");
			return false;
		}
			
		
		// 아래의 3개의 배열들역할 -> 각 칸들의 값들의 index 값을 넣어서, 해당 칸들의 개수가 일치해야 하는 조건을 추가할 수 있고
		// 칸들의 개수는 일치하지만, 각 칸들의 위치가 다를 수 있으므로, 배열의 인덱스번호를 추가함
		let arrayAccount = [];  
		let arrayUseHistory = [];
		let arrayPrice = [];
		$("input[name='account']").each(function(i){  // i로 인덱스번호 체크
			if(this.value != "") arrayAccount.push(i);
		})
		$("input[name='useHistory']").each(function(i){ 
			if(this.value != "") arrayUseHistory.push(i);
		})
		$("input[name='price']").each(function(i){
			if(this.value != "") arrayPrice.push(i);
		})
		
		// equals1, equals2 -> 배열은 == 비교가 불가능함(주소이기때문에) -> JSON.stringify를 통해서 비교 -> 3개의 배열을 비교
 		const equals1 = (arrayAccount, arrayUseHistory) => JSON.stringify(arrayAccount) == JSON.stringify(arrayUseHistory)
 		const equals2 = (arrayUseHistory, arrayPrice) => JSON.stringify(arrayUseHistory) == JSON.stringify(arrayPrice);
  		const result = equals1(arrayAccount, arrayUseHistory) && equals2(arrayUseHistory,arrayPrice);

		if(arrayAccount.length<=0 || arrayUseHistory.length<=0 || arrayPrice.length<=0){
			alert("각 목록마다 한칸이상씩 입력");
			return false;	
		}else{
			if(result == true){
				
			}else{
				alert("각 줄의 목록을 다 입력");
				return false;				
			}		
		}
		
 		$("#appForm").attr("action","${path}/approve/insertDraft.do"); 
		$("#appForm").submit(); 
		
	}
	
</script>
