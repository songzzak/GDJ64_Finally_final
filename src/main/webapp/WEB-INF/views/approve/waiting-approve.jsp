<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />

	<div id="waiting-approve-allarea">
	  <div id="letter">결재대기문서</div>
	  <div id="waiting-approve-content">
	  	 <table>
            <tr>
                <th>번호</th>
                <th>결재양식</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
         </table>
	  </div>
	</div>
	
<%-- 	<c:if test="${not empty apps}">
			<c:forEach var="app" items="${apps}">
				<tr>
					<td>${app.approveTitle}</td>
				</tr>
			</c:forEach>
	</c:if>  --%>
	
</section>
	<style>
		#waiting-approve-allarea{
			margin-top:20px;
			margin-left:40px;
			width: 1600px;
			height:900px;
			border: 1px solid black;
			background: white;
		}
	
		#letter{
			margin:20px;
			font-size: 30px;
			font-weight: bold;
		}
		
		#waiting-approve-content{
			margin-left : 30px;
			width: 1500px;
			height:750px;
			border: 1px solid #D9D9D9;
		}
	</style>
	