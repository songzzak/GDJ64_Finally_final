<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
/* 정렬, 색상 클래스 */
.row {
	display: flex;
	flex-direction: row;
}

.column {
	display: flex;
	flex-direction: column;
}

.center {
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
}

.bgc-fff {
	background-color: #fff;
}

.bgc-F8FCFF {
	background-color: #F8FCFF;
}

/* 출근부 nav */
.head-nav {
	height: 56px;
	display: flex;
	align-items: center;
}

.head-nav ul li {
	margin: 0px 5px;
}

/* 시간+버튼+연차 div */
#workBoardDiv {
	display: flex;
	align-items: stretch;
	justify-content: space-evenly;
}
/* 현재시간 */
#nowDateDiv {
	justify-content: space-evenly;
}

#workTimeTbl {
	width: 180px;
}
/* 출퇴근버튼 */
#work-ban-container button {
	width: 160px;
	height: 50px;
	margin: 5px 0px;
	color: #fff;
}
/* 연차확인 */
.roundBolder {
	width: 80px;
	height: 80px;
	border-radius: 50px;
	background-color: #BDDFFF;
	color: #fff;
	font-size: 32px;
	font-weight: bolder;
}

.smallRound {
	width: 30px;
	height: 30px;
	border-radius: 50px;
	background-color: #F3F7FA;
	color: #000000;
	font-size: 16px;
	font-weight: bolder;
}

#annualLeaveDiv {
	display: flex;
	text-align: center;
	align-items: center;
}

#annualLeaveDiv ul li {
	margin: 0 20px;
}

/* 근태조회 div */

/* 조회 월 선택 */
.year-month{font-size:24px;font-weight: bolder;text-align:center;color:black;}
.sec_cal { width: 360px;margin: 0 auto;font-family: "NotoSansR";}
.sec_cal .cal_nav {display: flex; justify-content: center;align-items: center;font-weight: 700;font-size: 48px;line-height: 72px;}
.sec_cal .cal_nav .year-month {width: 300px;text-align: center;line-height: 1;}
.sec_cal .cal_nav .nav {display: flex;border: 1px solid #333333;border-radius: 5px;}
.sec_cal .cal_nav .go-prev,
.sec_cal .cal_nav .go-next {display: block; width: 50px;height: 78px;font-size: 0;display: flex; justify-content: center;align-items: center;}
.sec_cal .cal_nav .go-prev::before,
.sec_cal .cal_nav .go-next::before {content: "";display: block;width: 20px; height: 20px;border: 3px solid #000;border-width: 3px 3px 0 0; transition: border 0.1s;}
.sec_cal .cal_nav .go-prev:hover::before,
.sec_cal .cal_nav .go-next:hover::before { border-color: var(--main-color-dk);}
.sec_cal .cal_nav .go-prev::before { transform: rotate(-135deg);}
.sec_cal .cal_nav .go-next::before {transform: rotate(45deg);}
</style>

<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />

	<div class="main-section bgc-F8FCFF">
		<div class="section-shadow bgc-fff head-nav">
			<ul class="row">
				<li>근태관리</li>
				<li>|</li>
				<li>내 출근부</li>
			</ul>
		</div>
		<div class="row section-shadow bgc-fff" id="workBoardDiv">
			<div id="nowDateDiv" class="column">
				<!-- 현재 시간 -->
				<c:set var="today" value="<%=new java.util.Date()%>" />
				<c:set var="date">
					<fmt:formatDate value="${today}" pattern="yyyy-MM-dd(E)" />
				</c:set>
				<div id="today" align="center">
					<c:out value="${date}" />
				</div>
				<div id="clock" style="font-size: 48px;"></div>
				<table id="workTimeTbl">
					<tr>
						<th>출근시간</th>
						<td>08:53:09</td>
					</tr>
					<tr>
						<th>퇴근시간</th>
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
						<p class="roundBolder center" style="background-color: #5F90CB">1</p>
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
		<div class="section-shadow bgc-fff">
			<div class="sec_cal">
				<div class="cal_nav">
					<a href="#" class="go-prev">prev</a>
					<div class="year-month"></div>
					<a href="#" class="go-next">next</a>
				</div>
				<div style="display: none;">
					<div class="cal_wrap">
						<div class="days">
							<div class="day">MON</div>
							<div class="day">TUE</div>
							<div class="day">WED</div>
							<div class="day">THU</div>
							<div class="day">FRI</div>
							<div class="day">SAT</div>
							<div class="day">SUN</div>
						</div>
						<div class="dates"></div>
					</div>
				</div>
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
   $(document).ready(function() {
	    calendarInit();
	});
   function calendarInit() {
	    // 날짜 정보 가져오기
	    var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
	    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
	    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
	    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
	  
	    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
	    // 달력에서 표기하는 날짜 객체
	  
	    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
	    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
	    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일
		var currentDay = thisMonth.getDay();
	    
	    // console.log(thisMonth);

	    // 캘린더 렌더링
	    renderCalender(thisMonth);

	    function renderCalender(thisMonth) {
	        // 렌더링을 위한 데이터 정리
	        currentYear = thisMonth.getFullYear();
	        currentMonth = thisMonth.getMonth();
	        currentDate = thisMonth.getDate();
	        currentDay = thisMonth.getDay();
	        var nowDate = new Date(currentYear, currentMonth, 1);
	        var currentYearMonth = currentYear + "" +(currentMonth+1);
	       
	        var lastDate = new Date(currentYear, currentMonth+1, 0).getDate();
	        var monthSWeek = nowDate.getDay();
	        var weekSeq = parseInt((parseInt(lastDate) + monthSWeek - 1)/7)+1;
		 	  console.log(currentYearMonth);
		 	 console.log(lastDate);
		 	 console.log("monthWeek:"+monthSWeek);
		 	  console.log(weekSeq);
		 	  
		 	// 이번 주 show
		 	    // 오늘 날짜에 이번달 시작하는 요일의 getDay를 더해서 한 주를 7의 배수로 만들기
		 	     var today = new Date();
		 	  //  var first = new Date(today.getFullYear(), today.getMonth(), 1);
		 	    var selectedDay = today.getDate();
		 	    var monthFirst = nowDate.getDay();
		 	    var todayWeek = Math.ceil((selectedDay + monthFirst) / 7);
		 	   	var dayList = ['일','월','화','수','목','금','토'];
		 	    var thisWeek = $('#'+todayWeek+'WeekTable').parents('.collapse');
		 	    thisWeek.addClass('show');
		 	    thisWeek.prev().find('i').removeClass('icofont-rounded-down').addClass('icofont-rounded-up');
		 	   
		 	    currentMonth1 = currentMonth+1;
		 		currentMonth1 = (currentMonth1 < 10) ? "0" + currentMonth1 : currentMonth1;
		 		console.log("현재월:"+currentMonth1);

	        $.ajax({
		    	url:'deptWorkTime.em',
		    	data:{currentYearMonth:currentYearMonth,
		    		currentYear:currentYear,
		    		currentMonth1:currentMonth1,
		    		weekSeq:weekSeq,
		    	},
		    	dataType: 'json',
		    	success:function(data){
		    		console.log("부서별 성공");
					console.log(data);	
					for(var i = 1; i <= weekSeq; i++){
						var cl = "<th style='border-bottom: 1px solid black; height:22px;'>"+i+"주차"+"</th>";

                    $('#worktable').append(cl);
					}
					 $tableBody = $('#deptTotalTable tbody');
					 $tableBody.html('');

						$.ajax({
							url:'personalWorkTime.em',
					    	data:{currentYearMonth:currentYearMonth,
					    		currentYear:currentYear,
					    		currentMonth1:currentMonth1,
					    		weekSeq:weekSeq,
					    	},
					    	dataType: 'json',
					    	success:function(result){
					    		console.log("주별 성공");
								console.log(result);	
								for(var i in data){
									console.log(data[i].weekNum);
									console.log(typeof data[i].weekNum);
									console.log(data[i].monthWork);
								   $tr = $('<tr>');
									$id = $('<td>').text(data[i].mName);
									$monthWork = $('<td>').text(data[i].monthWork);
									$monthOver = $('<td>').text(data[i].monthOver);
									console.log(data[i].weekNum == 1);
									$tr.append($id);	
									$tr.append($monthWork);
									$tr.append($monthOver);
									$tableBody.append($tr);

									for(var j in result){
										console.log(j+"j:"+result[j].mId);
										 if(result[j].mId == data[i].mId){
											if(result[j].strOverTime !=''){
											$work = $('<td class="weekTd">').text("업무 : "+result[j].strGapTime +"\n"+"초과 :"+result[j].strOverTime);
											}else{
												$work = $('<td class="weekTd">').text("업무 : "+result[j].strGapTime);
											}
											$tr.append($work);
											$tableBody.append($tr);
										} 
									}

								}
					    		
					    	},
					    	error:function(result){
								console.log(result);	
					    	}
						});
		    	},
		    	error:function(data){
					console.log(data);
				}
		    });

	        // 이전 달의 마지막 날 날짜와 요일 구하기
	        var startDay = new Date(currentYear, currentMonth, 0);
	        var prevDate = startDay.getDate();
	        var prevDay = startDay.getDay();

	        // 이번 달의 마지막날 날짜와 요일 구하기
	        var endDay = new Date(currentYear, currentMonth + 1, 0);
	        var nextDate = endDay.getDate();
	        var nextDay = endDay.getDay();
	    
	        // 현재 월 표기
	        $('.year-month').text(currentYear + '.' + (currentMonth + 1));
			
	        // 렌더링 html 요소 생성
	        calendar = document.querySelector('.dates')
	        calendar.innerHTML = '';
	        
	        // 지난달
	        for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable">' + i + '</div>'
	        }
	        // 이번달
	        for (var i = 1; i <= nextDate; i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day current">' + i + '</div>'
	        }
	        // 다음달
	        for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
	            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
	        }

	        // 오늘 날짜 표기
	        if (today.getMonth() == currentMonth) {
	            todayDate = today.getDate();
	            var currentMonthDate = document.querySelectorAll('.dates .current');
	            currentMonthDate[todayDate -1].classList.add('today');
	        }
	    }

	    // 이전달로 이동
	    $('.go-prev').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth - 1, 1);
	        $('#worktable').children().remove();
	        renderCalender(thisMonth);
	    });

	    // 다음달로 이동
	    $('.go-next').on('click', function() {
	        thisMonth = new Date(currentYear, currentMonth + 1, 1);
	        $('#worktable').children().remove();
	        renderCalender(thisMonth); 
	    });
	}
</script>

</body>
</html>