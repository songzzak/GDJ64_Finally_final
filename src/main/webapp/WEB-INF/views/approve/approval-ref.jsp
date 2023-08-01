<!-- 모든양식에서 공통으로 사용할 결재선 UI -->

<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>	
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>	
<%-- <c:set var="path" value="${pageContext.request.contextPath }"/>
<script src="${path}/resources/js/jquery-3.7.0.min.js"></script> --%>
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
		<c:if test="${not empty deps}">
			<c:forEach var="dep" items="${deps}">
				<button onclick="changeDep(event);" value="${dep.deptName}">${dep.deptName}</button><br>
			</c:forEach>
		</c:if>
	    </div>
	    
	    <div id="people-box">
<%-- 	    	<c:forEach var="member" items="${members}">
	    		<input type="checkbox">${member.memberName} ${member.job.jobName} ${member.dept.deptName}
	    	</c:forEach> --%>
	    	
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

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/approve/approve.js"></script>
<script>



	 const changeDep=(e)=>{
		 /* console.log(e.target.value); */
		 	const value = e.target.value;
			$.post("${path}/approve/changeDep.do",
					{deptName:value},  
					data=>{  // 데이터를 객체로(키,값) 전달

						for(let i=0; i<data.length; i++){
							console.log(data[i].memberName, data[i].job.jobName, data[i].dept.deptName);
						}
					
					}); 
	 }
	 
/* 	const changeDept=()=>{
		$.post("${pageContext.request.contextPath}/ajax/insertData.do",
				deptName:"${dept}",  
				data=>{  // 데이터를 객체로(키,값) 전달
					console.log(data);
				}); 
	}   */
</script>	
	
</html>