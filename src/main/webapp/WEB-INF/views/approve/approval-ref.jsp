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

	    	
	    </div>
	    
		<div id="add-remove">
			<span id="first-arrow">
			    <button type="button" style="width: 30px; height: 30px; background-color:white">
		  			<img src="/resources/images/arrow/right.png" height="30px" width="30px" onclick="applyOn();" >
				</button>
			</span>
		
			<span id="second-arrow">
					<button type="button" style="width: 30px; height: 30px; background-color:white">
					    <img src="/resources/images/arrow/left.png" height="30px" width="30px" onclick="applyOff();" >
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

<style>
	#people-box {
		font-size: 15px;
	}
</style>
<script>

	 const changeDep=(e)=>{  // 결재선 선택창에서 부서 눌렀을 때
		 	const value = e.target.value;
			$.post("${path}/approve/changeDep.do",
					{deptName:value},  
					data=>{  // 데이터를 객체로(키,값) 전달
						$("#people-box").empty(); // #people-box 밑에 자식요소들 모두삭제
						for(let i=0; i<data.length; i++){
							var a = [data[i].memberId,data[i].memberName,data[i].job.jobName,data[i].dept.deptName];
							$("#people-box").append($('<input/>', {type: 'checkbox', name: 'peopleBox', value:a, width:'30px', margin:"10px"}));
							$("#people-box").append(data[i].memberId,'&nbsp;',data[i].memberName,'&nbsp;',data[i].job.jobName,'&nbsp;',data[i].dept.deptName, '<br>')
						}			
					}); 
	 }
	 
	 const applyOn=()=>{ // 결재선 목록에 -> 화살표눌렀을 때
		 console.log($('input:checkbox[name="appBox"]').length);
		 
		 if($('input:checkbox[name="peopleBox"]:checked').length == 0){ //결재선에 추가할 체크박스에 체크된개수가 0개이면
			 alert("사원을 선택해주세요");
		 }else{ // 그외 체크된개수가 1개이상이면
			 $('input:checkbox[name="peopleBox"]:checked').each(function(){ // 체크된것들을 foreach문으로 비교
				 var flag = false;
				 const str = this.value.split(",");
				 
				$('input:checkbox[name="appBox"]').each(function(){  // 결재선에 추가되있는 사람을 중복확인하기위한 로직
					const app = this.value.split(",");
					if(str[0]==app[0]){
						flag = true; // 추가되있는 명단과, 추가할 사람의 사원번호가 동일하면 그 사람은 flag값을 true로
					}
				 }) 
				 
				if(flag==false){
					if($('input:checkbox[name="appBox"]').length>=3){ //추가할 명단이 중복되지않았을때, 최대인원이 3명으로 제한
						alert("최대 3명까지만 결재신청 가능합니다");
						return false;
					}else{ // 그외에는 추가함
						$("#line-box").append($('<input/>', {type: 'checkbox', name: 'appBox', value:str[0], width:'30px', margin:"10px"}));
						$("#line-box").append(str[0],'&nbsp;',str[1],'&nbsp;',str[2],'&nbsp;',str[3], '<br>')
					}

				}else{ // flag값이 true일 경우에는 추가하지않음
					alert("이미 등록된 사원입니다");
					return false;
				}
			 }) 
			 $("input:checkbox[name=peopleBox]").prop("checked", false); // 다 추가하고나서 선택창의 체크박스 초기화
		 }
	 } 
	
	 
	 const applyOff=()=>{  // 결재선 목록에 <- 버튼 눌렀을때
		
		 if($('input:checkbox[name="appBox"]:checked').length == 0){ //name="peopleBox"인 체크박스에 체크된개수가 0개이면
			 alert("결재선 취소할 사원을 선택해주세요");
		 }else{
			 $('input:checkbox[name="appBox"]:checked').each(function(){
				console.log(this.value); // value 값기준으로 태그삭제			 
			 })
		 }
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