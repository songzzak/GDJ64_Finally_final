<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />


<jsp:include page="/WEB-INF/views/common/header.jsp" />


<link rel="stylesheet"
	href="${path}/resources/css/approve/drafting_app.css">
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	
	<!-- 기안서 양식 -->
<!-- 	<div class="approve-section section-shadow">
		<div id="approve_name">결재서이름 + 신청</div>

		<div>
			<div id="one-width">
				<div id="kind" class="answer"></div>
				<div id="app-line" class="answer"></div>
			</div>

			<div id="one-width">
				<div id="title" class="question">제목</div>
				<div id="title-answer" class="answer">
					<input type="text" id="title-input">
				</div>
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
				<div id="effectDate" class="question">시행일자</div>
				<div id="effectDate-answer" class="answer">
					<input type="date" id="effectDate-input">
				</div>
				<div id="writeDate" class="question">작성일</div>
				<div id="writeDate-answer" class="answer"></div>
			</div>

			<div id="one-width">
				<div id="content" class="question">내용</div>
				<div id="content-answer" class="answer">
					<textarea id="content-textarea">
        </textarea>
				</div>
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
	</div>  -->
	<!-- 여기까지가 기안서양식 -->
	
	
	<!-- 여기부터 연장근무서 양식 -->
<!-- 		<div class="approve-section section-shadow">
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
				<div id="extendWork" class="question">근무일시</div>
				<div id="extendWork-answer" class="answer">
					<input type="date" id="extendWorkDate-input">
					<input type="time" id="extendWorkTime1-input">
					<span id="betweenTime">~</span>
					<input type="time" id="extendWorkTime2-input">
				</div>
			</div>
	
			<div id="one-width">
				<div id="extendTimeTitle" class="question">제목</div>
				<div id="extendTimeTitle-answer" class="answer">
					<input type="text" id="title-input">
				</div>
			</div>
			
			<div id="one-width">
				<div id="content" class="question">신청사유</div>
				<div id="content-answer" class="answer">
					<textarea id="content-textarea"></textarea>
				</div>
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
	</div> -->
	<!-- 여기까지가 연장근무서 양식 -->
	
	
	<!-- 여기부터 근태신청서 양식 -->
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
				<div id="attendance-kind" class="question">종류</div>
				<div id="div-annual" class="answer">연차<input type="radio" id="annual" name=geuntae></div>
				<div id="div-halfAnuual" class="answer">반차<input type="radio" id="halfAnuual" name=geuntae></div>
				<div id="div-health" class="answer">보건<input type="radio" id="health" name=geuntae></div>
				<div id="div-condolences" class="answer">경조<input type="radio" id="condolences" name=geuntae></div>
				<div id="div-training" class="answer">훈련<input type="radio" id="training" name=geuntae></div>
				<div id="div-outing" class="answer">외출<input type="radio" id="outing" name=geuntae></div>
			</div>			
						
						
			<div id="one-width">
				<div id="extendWorkWriteDate" class="question">작성일</div>
				<div id="extendWorkWriteDate-answer" class="answer"></div>
			</div>
			

			<div id="one-width">
				<div id="applicationDate" class="question">신청일</div>
				<div id="applicationDate-answer" class="answer">
					<input type="date" id="applicationDate-input">
					<span id="betweenTime">~</span>
					<input type="date" id="applicationDate-input">
					
<!-- 외출, 훈련은 시간을선택하게함
					<input type="time" id="applicationDate-input">
					<span id="betweenTime">~</span>
					<input type="time" id="applicationDate-input"> -->
				</div>
			</div>
	
			<div id="one-width">
				<div id="extendTimeTitle" class="question">제목</div>
				<div id="extendTimeTitle-answer" class="answer">
					<input type="text" id="title-input">
				</div>
			</div>
			
			<div id="one-width">
				<div id="content" class="question">신청사유</div>
				<div id="content-answer" class="answer">
					<textarea id="content-textarea"></textarea>
				</div>
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
	
	<!-- 여기까지가 근태신청서 양식 -->
	
	
	<div class="approve-section1 section-shadow">
		<button type="button" id="regist-appline">결재선 설정</button>

		<!-- <button type="button" id="regist-appline">결재선 설정</button> -->
		<div id="regist-app">
			<div id="appline-name">결재선</div>
		</div>

		<div id="regist-reference">
			<div id="reference-name">참조선</div>
		</div>
	</div>

</section>
</html>
