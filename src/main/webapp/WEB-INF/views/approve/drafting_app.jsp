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
	
		
	<!-- 지출결의서 양식 -->
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
		
	<!-- 여기까지가 지출결의서 양식 -->
	
	
	
	
	
	<div class="approve-section1 section-shadow">
		<button type="button" class="openBtn" id="regist-appline">결재선 설정</button>

		<!-- <button type="button" id="regist-appline">결재선 설정</button> -->
		<div id="regist-app">
			<div id="appline-name">결재선</div>
		</div>

		<div id="regist-reference">
			<div id="reference-name">참조선</div>
		</div>
	</div>

</section>



  <div class="modal hidden">
  <div class="bg"></div>
  <div class="modalBox">
  	<div id="display-flex">
	    <div id="department-box">
			    	
	    </div>
	    
	    <div id="people-box">
	    	
	    </div>
	    
		<div id="add-remove">
			<span id="first-arrow">
			    <button type="button" style="width: 30px; height: 30px; background-color:white">
		  			<img src="/resources/images/arrow/right.png" height="30px" width="30px" onclick="" >
				</button>
			</span>
		
			<span id="second-arrow">
					<button type="button" style="width: 30px; height: 30px; background-color:white">
					    <img src="/resources/images/arrow/left.png" height="30px" width="30px" onclick="" >
					</button>
			</span>
		
			<span id="three-arrow">
				<button type="button"style="width: 30px; height: 30px; background-color:white">
				  <img src="/resources/images/arrow/right.png" height="30px" width="30px" onclick="" >
				</button>
			</span>
			
			<span id="four-arrow">
				<button type="button"  style="width: 30px; height: 30px; background-color:white">
				  <img src="/resources/images/arrow/left.png" height="30px" width="30px" onclick="" >
				</button>
			</span>	
		</div>
	    
	    <div id="line-refer-box">
	    		<div id="line-box">
	    			<p id="line-box-text">결재선</p>
	    				
	    		</div>
	    		
	    		<div id="refer-box">
	    			<p id="refer-box-text">참조선</p>
	    			
	    		</div>
	    </div>
	</div>


		<button type="button" id="close-button">닫기</button>
		<button type="button" id="regist-button">등록</button> 
  </div>
</div>

</html>

<script>
const open = () => {
    document.querySelector(".modal").classList.remove("hidden");
  }

  const close = () => {
    document.querySelector(".modal").classList.add("hidden");
  }

  document.querySelector(".openBtn").addEventListener("click", open);
  document.querySelector("#close-button").addEventListener("click", close);
  document.querySelector(".bg").addEventListener("click", close);
</script>




