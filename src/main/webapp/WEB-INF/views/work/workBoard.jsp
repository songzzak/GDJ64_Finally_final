<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
	.main-section ul>li{
	list-style-type: none;
	}
	.row{
	   display: flex;
	   flex-direction: row;
	}
	.column{
	   display: flex;
	   flex-direction: column;
	}
	#work-ban-container button{
	   width: 160px;
	   height: 50px;
	   margin: 10px 10px;
	   color:#fff;
	}
	
	.roundBolder{
	   width: 80px;
	   height: 80px;
	   border-radius: 50px;
	   background-color: #BDDFFF;
	   color: #fff;
	   font-size:32px;
	   font-weight:bolder;
	}
	.smallRound{
	   width: 30px;
	   height: 30px;
	   border-radius: 50px;
	   background-color: #F3F7FA;
	   color: #000000;
	   font-size:16px;
	   font-weight:bolder;
	}
	
	.center{
	   display: flex;
	   align-items: center;
	   justify-content: center;
	}
	
	#annualLeaveDiv ul li{
	   margin: 0 20px;
	}
</style>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
	
	<div class="main-section">		
	 	<div class="section-shadow">
	         <ul class="row">
	            <li>근태관리</li>
	            <li>|</li>
	            <li>내 출근부</li>
	         </ul>
	      </div>
	      <div class="row section-shadow">
	         <div id="nowDateDiv" >
	            <!-- 현재 시간 -->
	            <c:set var="today" value="<%=new java.util.Date()%>" />
                <c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd(E)" /></c:set>
				<div id="today" align="center"><c:out value="${date}" /></div>
	            <div id="clock" style="font-size:48px;"></div>
	            <table>
	               <tr>
	                  <td>출근시간</td>
	                  <td>08:53:09</td>
	               </tr>
	               <tr>
	                  <td>퇴근시간</td>
	                  <td>미등록</td>   
	               </tr>
	            </table>
	         </div>
	         <div class="column" id="work-ban-container">
	            <button>출근</button>
	            <button>퇴근</button>
	            <button>출퇴근 수정 요청</button>
	         </div>
	         <hr style="margin: 20px 30px;">
	         <div id="annualLeaveDiv">
	            <ul class="row">
	               <li>
	                  <p class="roundBolder center">15</p>
	                  <p>총연차</p>
	               </li>
	               <li>
	                  <p class="roundBolder center">2</p>
	                  <p>사용 연차</p>
	               </li>
	               <li>
	                  <p class="roundBolder center">13</p>
	                  <p>잔여 연차</p>
	               </li>
	               <li>
	                  <p class="roundBolder center">1</p>
	                  <p>지각계</p>
	               </li>
	               <li>
	                  <p class="roundBolder center">0</p>
	                  <p>조퇴계</p>
	               </li>
	               <li>
	                  <p class="roundBolder center">0</p>
	                  <p>결근계</p>
	               </li>
	            </ul>
	         </div>
	      </div>
      <div class="section-shadow">
         <table  class="center">
            <tr>
               <th>일자</th>
               <th>근태정보</th>
               <th>부재사항</th>
               <th>출근시간</th>
               <th>퇴근시간</th>
               <th>외출시간</th>
               <th>복귀시간</th>
               <th>기본근무시간</th>
               <th>연장근무시간</th>
            </tr>
            <tr>
               <td class="row">
                  <p class="smallRound center">1</p>
                  <p>화</p>
               </td>
               <td>정상출근</td>
               <td>-</td>
               <td>08:50</td>
               <td>18:03</td>
               <td>12:00</td>
               <td>14:09</td>
               <td>9:00 - 18:00</td>
               <td>18:00 - 20:30</td>
            </tr>
            <tr>
               <td class="row">
                  <p class="smallRound center">2</p>
                  <p>수</p>
               </td>
               <td>정상출근</td>
               <td>-</td>
               <td>08:50</td>
               <td>18:03</td>
               <td>12:00</td>
               <td>14:09</td>
               <td>9:00 - 18:00</td>
               <td>18:00 - 20:30</td>
            </tr>
         </table>
      </div>
   </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
      // 페이지가 로드되면 시계를 출력하도록 호출
      printClock();
   });

   function printClock() {
      var clock = $("#clock");
      var currentDate = new Date(); //현재시간
      var currentHours = addZeros(currentDate.getHours(),2); 
      var currentMinute = addZeros(currentDate.getMinutes(), 2);
      var currentSeconds = addZeros(currentDate.getSeconds(), 2);
      
      if (currentSeconds >= 50) { // 50초 이상일 때 색을 변환해 준다.
         currentSeconds = '<span style="color:#de1951;">' + currentSeconds + '</span>';
      }

      clock.html(currentHours + ":" + currentMinute + ":" + currentSeconds); //날짜를 출력해 줌
      setTimeout(printClock, 1000); // 1초마다 printClock() 함수 호출
   }

   function addZeros(num, digit) { //자릿수 맞춰주기
      var zero = '';
      num = num.toString();
      if (num.length < digit) {
         for (var i = 0; i < digit - num.length; i++) {
            zero += '0';
         }
      }
      return zero + num;
   }
</script>

</body>
</html>