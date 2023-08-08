<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
  /* 정렬, 색상 클래스 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }
  .margin10px label, .margin10px input, .margin10px textarea,.margin10px button{margin: 10px;}

  /* 근태관리 nav */
  .head-nav { height: 56px; display: flex; align-items: center; }
  .head-nav ul li { margin: 0px 5px; }
  /* 조회 월 선택 */
  .sec_cal { width: 100%; margin: 0 auto; font-family: "NotoSansR"; }
  .cal_tblDiv { display: flex; flex-direction: column; align-items: flex-start; }
  .cal_tbl { width: 95%; margin: 0px 20px; padding: 10px; border-collapse: collapse; }
  .cal_tbl td, .cal_tbl th { border-bottom: 1px solid var(--border-color); padding: 8px; text-align: center; }
  
/* 요청사유 표시 길이 제한 */
.short-reason {white-space: nowrap;overflow: hidden;text-overflow: ellipsis;max-width: 50px;}
/* 호버 시 전체 내용 표시 */
.short-reason:hover {white-space: normal;overflow: visible;max-width: none;}
  
</style>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	<div class="main-section bgc-F8FCFF">		
	    <div class="section-shadow bgc-fff head-nav">
	      <ul class="row" style="margin-left: 30px">
	        <li>근태관리</li>
	        <li>|</li>
	        <li>출퇴근 시간 수정</li>
	      </ul>
	    </div>
	    <div class="row section-shadow bgc-fff" id="workChangeDiv">
	      <div class="sec_cal">
	        <div class="cal_tblDiv" style="padding: 10px;">
	         <table class="cal_tbl">
	         	<thead>
	         		<tr>
	         			<th>번호</th>
	         			<th>출근일자</th>
	         			<th>사원번호</th>
	         			<th>소속 팀</th>
	         			<th>직급</th>
	         			<th>사원명</th>
	         			<th>출근시간</th>
	         			<th>퇴근시간</th>
	         			<th>요청사유</th>
	         			<th>수정상태</th>
	         			<th></th>
	         		</tr>
	         	</thead>
	         	<tbody>
	         	<c:if test="${empty workChangeList }">
	         	<tr>
	         		<td colspan="10">조회된 출퇴근 수정 요청이 없습니다.</td>
	         	</tr>
	         	</c:if>
				<c:if test="${not empty workChangeList }">
					<c:forEach var="changeItem" items="${workChangeList }">
						 <tr class="work-change-row">
						 	<td><c:out value="${changeItem.workChangeNo }"/></td>
			                <td> <fmt:formatDate value="${changeItem.work.workDate}" pattern="yy/MM/dd E" /></td>
			                <td><c:out value="${changeItem.work.member.memberId }"/></td>
			                <td><c:out value="${changeItem.work.member.dept.deptName }"/></td>
			                <td><c:out value="${changeItem.work.member.job.jobName }"/></td>
			                <td><c:out value="${changeItem.work.member.memberName }"/></td>
			                <td><fmt:formatDate value="${changeItem.work.workStart}" pattern="HH:mm:ss" /></td>
			                <td><fmt:formatDate value="${changeItem.work.workEnd}" pattern="HH:mm:ss" /></td>
			                <td class="short-reason"><c:out value="${changeItem.reason }"/></td>
			                <td><c:out value="${changeItem.changeStatus }"/></td>
			                <td>
			                	<button>승인</button>
			                	<button>삭제</button>
			                </td>
	          			  </tr>
					</c:forEach>
				</c:if>
	         	</tbody>
	         </table>
	        </div>
	      </div>
	      <div id="pageBarDiv">
	      
	      </div>
	    </div>
	</div>
</section>


</body>
</html>