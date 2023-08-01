<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />


<jsp:include page="/WEB-INF/views/common/header.jsp" />


<link rel="stylesheet"
	href="${path}/resources/css/approve/drafting_app.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />

	
		<div class="approve-section section-shadow">
		<div id="approve_name">결재서이름 + 신청</div>

		<div>
			<div id="one-width">
				<div id="kind" class="answer"></div>
				<div id="app-line" class="answer"></div>
			</div>

			<div id="one-width">
				<div id="department" class="question">부서</div>
				<div id="department-answer" class="answer"></div>
				<div id="writer" class="question">기안자</div>
				<div id="writer-answer" class="answer"></div>
				<div id="position" class="question">직책</div>
				<div id="position-answer" class="answer"></div>
			</div>
						
			<div id="one-width">
				<div id="extendWorkWriteDate" class="question">작성일</div>
				<div id="extendWorkWriteDate-answer" class="answer"></div>
			</div>
			

			
			<div id="one-width">
				<div id="account" class="question">거래처</div>
				<div id="use-history" class="question">사용내역 및 용도</div>
				<div id="price" class="question">금액</div>
			</div>
			<div id="one-width">
					<input type="text" id="account0" name="account"  class="answer">
					<input type="text" id="use-history0" name="use-history"  class="answer">
					<input type="text" id="price0" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account1" name="account"  class="answer">
					<input type="text" id="use-history1" name="use-history"  class="answer">
					<input type="text" id="price1" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account2" name="account"  class="answer">
					<input type="text" id="use-history2" name="use-history"  class="answer">
					<input type="text" id="price2" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account3" name="account"  class="answer">
					<input type="text" id="use-history3" name="use-history"  class="answer">
					<input type="text" id="price3" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account4" name="account"  class="answer">
					<input type="text" id="use-history4" name="use-history"  class="answer">
					<input type="text" id="price4" name="price"  class="answer">
			</div>
			<div id="one-width">
					<input type="text" id="account5" name="account"  class="answer">
					<input type="text" id="use-history5" name="use-history"  class="answer">
					<input type="text" id="price5" name="price"  class="answer">
			</div>

			<div id="one-width">
				<div id="appAttachment" class="question">첨부파일</div>
				<div id="appAttachment-answer" class="answer">
					<input type="file" id="appAttachment-input">
				</div>
			</div>

			<div id="one-width">
				<button type="button" id="back">돌아가기</button>
				<button type="button" id="save">임시저장</button>
				<button type="button" id="sign">결재상신</button>
			</div>

		</div>
	</div> 



<jsp:include page="/WEB-INF/views/approve/approval-ref.jsp"/>
