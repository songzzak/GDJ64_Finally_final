<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<section class="max1920px">
<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
	<div class="main-section section-shadow card">
      <div class="right-container">
         <h2>사원 등록</h2>
         <form action="${path }/employee/enroll" method="post" id="enroll-form">
         	<div>
         		<span>이름</span>
         		<input type="text" name="memberName">
         	</div>
         	<div>
         		<span>주민번호</span>
         		<input type="text" name="memberNo">
         	</div>
         	<div>
         		<span>전화번호</span>
         		<input type="text" name="phone">
         		<p>* 전화번호 입력 시 하이픈(-) 제외하고 입력하세요.</p>
         	</div>
         	<div>
         		<span>주소 검색</span>
         		<input type="text" name="mainAddress" id="main-addr">
         		<input type="button" onclick="fn_searchAddr();" value="검색">
         	</div>
         	<div>
         		<span>상세 주소</span>
         		<input type="text" name="detailAddress" id="detail-addr">
         	</div>
         	<div>
         		<span>부서</span>
	         	<select name="deptCode">
	         		<option selected disabled>필수 선택</option>
	         		<c:if test="${depts!=null }">
		         		<c:forEach var="d" items="${depts }">
		         			<option value="${d.deptCode }">${d.deptName }</option>
	         			</c:forEach>
	         		</c:if>
	         	</select>
         	</div>
         	<div>
         		<span>직책</span>
	         	<select name="jobCode">
	         		<option selected disabled>필수 선택</option>
	         		<c:if test="${jobs!=null }">
		         		<c:forEach var="j" items="${jobs }">
		         			<option value="${j.jobCode }">${j.jobName }</option>
	         			</c:forEach>
	         		</c:if>
	         	</select>
         	</div>
         	<div>
         		<span>급여</span>
         		<input type="number" name="salary">
         	</div>
         	<div>
         		<span>입사일</span>
         		<input type="date" name="enrollDate">
         	</div>
         </form>
         <p>* 사원 초기 비밀번호는 1234로 생성됩니다.</p>
      </div>
   </div>
	<div><input type="reset" value="취소"><button onclick="fn_empDataCk();">생성</button></div>
</section>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//주소 검색 메소드
	function fn_searchAddr(){
		//주소 API 사용
		 new daum.Postcode({
		        oncomplete: function(data) {
		        	$("#main-addr").val(data.address);
		        	$("#detail-addr").focus();
		        }
		    }).open();
	}
	
	//데이터 입력 확인 후 넘기는 메소드
	function fn_empDataCk(){
		$("#enroll-form").submit();
	}
</script>
</body>
</html>