<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>

	
	<div id="saveDocument" class="approve-section section-shadow">
		<span id="saveDocumentFont">임시저장문서</span>
		<div id="saveDocumentDiv">
			<table class="table">
            <tr id="th">
                <th colspan="6">번호</th>
                <th colspan="6">결재양식</th>
                <th colspan="6">제목</th>
                <th colspan="6">작성자</th>
                <th colspan="6">작성일</th>
                <th colspan="6">상태</th>
            </tr>
            <c:if test="${not empty saveApps}">
            	<c:forEach var="sa" items="${saveApps}">
	            		<tr id="tr">
		            			<td colspan="6">${sa.approveNo }</td>
		            			<td colspan="6">${sa.approveKind }</td>
		            			<td colspan="6">${sa.approveTitle }</td>
		            			<td colspan="6">${sa.memberId.memberName}</td>
		            			<td colspan="6">${sa.currentDate }</td>
		            			<td colspan="6"><button id="saveColor" onclick="location.href='${path}/approve/detailSave.do?approveNo=${sa.approveNo}&approveKind=${sa.approveKind}';">
		            			${sa.approveState}</button></td>
	            		</tr>
	            		
            	</c:forEach>
            </c:if>
        </table>
       
		</div>
	</div>

</html>	

<style>
	#saveDocumentFont{
		font-weight: bold;
		font-size: 25px;
		margin-left:25px;
   		margin-top: 50px;	
	}

	#saveDocument{
		background-color:white;
		border: 1px solid #D9D9D9;
		width:1700px;
		height:900px;
		margin-left: 50px;
	}
	
	#saveDocumentDiv{
		border: 1px solid #D9D9D9;
		margin-top : 20px;
		margin-left : 50px;
		width:1600px;
		height:770px;
	}
	
	#th>th{
		font-size:20px;
		padding-left:70px;
		padding-top:50px;
		padding-right:100px;
		padding-bottom:20px;
		border-bottom: 1px solid #ddd;
	}
		
	#tr>td{
		font-size:15px;
		padding-left:70px;
		padding-right:100px;
		padding-top:15px;
		padding-bottom:15px;
		border-bottom: 1px solid #ddd;
		text-align: center;
	}
	
	#saveColor{
		background-color :#F5F5DC;
	}
</style>