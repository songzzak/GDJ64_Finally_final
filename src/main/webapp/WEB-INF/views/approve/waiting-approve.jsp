<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>

	
	<div id="waitingDocument" class="approve-section section-shadow">
		<span id="waitingDocumentFont">결재대기문서함</span>
		<div id="waitingDocumentDiv">
		<table class="table">
            <tr id="th">
                <th colspan="5">번호</th>
                <th colspan="5">결재양식</th>
                <th colspan="5">제목</th>
                <th colspan="5">작성자</th>
                <th colspan="5">작성일</th>
            </tr>
            <c:if test="${not empty waitingApps}">
            	<c:forEach var="waitingApp" items="${waitingApps}">
	            		<tr id="tr" onclick="location.href='${path}/approve/detailApprove.do?approveNo=${waitingApp.approveNo}&approveKind=${waitingApp.approveKind }&approveState=${waitingApp.approveState}&name=결재대기문서';">
		            			<td colspan="5">${waitingApp.approveNo }</td>
		            			<td colspan="5">${waitingApp.approveKind }</td>
		            			<td colspan="5">${waitingApp.approveTitle }</td>
		            			<td colspan="5">${waitingApp.memberId.memberName}</td>
		            			<td colspan="5">${waitingApp.currentDate }</td>
	            		</tr>	
            	</c:forEach>
            </c:if>
        </table>
       
		</div>
	</div>

</html>	

<style>
	#waitingDocumentFont{
		font-weight: bold;
		font-size: 25px;
		margin-left:25px;
   		margin-top: 50px;	
	}

	#waitingDocument{
		background-color:white;
		border: 1px solid #D9D9D9;
		width:1720px;
		height:900px;
		margin-left: 50px;
	}
	
	#waitingDocumentDiv{
		border: 1px solid #D9D9D9;
		margin-top : 20px;
		margin-left : 50px;
		width:1650px;
		height:770px;
	}

	#th>th{
		font-size:20px;
		padding-left:140px;
		padding-top:50px;
		padding-right:100px;
		padding-bottom:20px;
		border-bottom: 1px solid #ddd;
	}
		
	#tr:hover{
		background-color:  #BDDFFF;
	}	
		
	#tr>td{
		font-size:15px;
		padding-left: 140px;
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