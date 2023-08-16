<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>

	
	<div id="draftDocument" class="approve-section section-shadow">
		<span id="draftDocumentFont">기안문서</span>
		<div id="draftDocumentDiv">
			<table class="table">
            <tr id="th">
                <th colspan="6">번호</th>
                <th colspan="6">결재양식</th>
                <th colspan="6">제목</th>
                <th colspan="6">작성자</th>
                <th colspan="6">작성일</th>
                <th colspan="6">상태</th>
            </tr>
            <c:if test="${not empty draftDocuments}">
            	<c:forEach var="draftDocument" items="${draftDocuments}">
	            		<tr id="tr" onclick="location.href='${path}/approve/detailApprove.do?approveNo=${draftDocument.approveNo}&approveKind=${draftDocument.approveKind}&approveState=${draftDocument.approveState}&name=기안문서함';">
		            			<td colspan="6">${draftDocument.approveNo }</td>
		            			<td colspan="6">${draftDocument.approveKind }</td>
		            			<td colspan="6">${draftDocument.approveTitle }</td>
		            			<td colspan="6">${draftDocument.memberId.memberName}</td>
		            			<td colspan="6">${draftDocument.currentDate }</td>
		            			
		            			<c:if test="${draftDocument.approveState eq '완료'}">
		            				<td colspan="6"><p id="cColor">${draftDocument.approveState}</p></td>
		            			</c:if>
		            			<c:if test="${draftDocument.approveState eq '반려'}">
		            				<td colspan="6"><p id="rColor">${draftDocument.approveState}</p></td>
		            			</c:if>
		            			<c:if test="${draftDocument.approveState eq '결재처리중'}">
		            				<td colspan="6"><p id="pColor">${draftDocument.approveState}</p></td>
		            			</c:if>
		            			<c:if test="${draftDocument.approveState eq '결재대기'}">
		            				<td colspan="6"><p id="wColor">${draftDocument.approveState}</p></td>
		            			</c:if>
	            		</tr>
	            		
            	</c:forEach>
            </c:if>
        </table>
       
		</div>
	</div>

</html>	

<style>
	#draftDocumentFont{
		font-weight: bold;
		font-size: 25px;
		margin-left:25px;
   		margin-top: 50px;	
	}

	#draftDocument{
		background-color:white;
		border: 1px solid #D9D9D9;
		width:1720px;
		height:900px;
		margin-left: 50px;
	}
	
	#draftDocumentDiv{
		border: 1px solid #D9D9D9;
		margin-top : 20px;
		margin-left : 50px;
		width:1650px;
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
	
	#tr:hover{
		background-color:  #BDDFFF;
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
	
	#cColor,#rColor,#pColor,#wColor{
		font-size: 15px;
	background-color: white;
	}
	
	#cColor{
		color :green;
	}
	#rColor{
		color :red;
	}
	#pColor{
		color :aqua;
	}
	#wColor{
		color :var(--main-color-lt);
	}
	
</style>