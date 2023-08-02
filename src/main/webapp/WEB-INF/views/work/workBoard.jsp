<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.TimeZone" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<style>
  /* 정렬, 색상 클래스 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }

  /* 출근부 nav */
  .head-nav { height: 56px; display: flex; align-items: center; }
  .head-nav ul li { margin: 0px 5px; }

  /* 시간+버튼+연차 div */
  #workBoardDiv { display: flex; align-items: stretch; justify-content: space-evenly; }
  /* 현재시간 */
  #nowDateDiv { justify-content: space-evenly; }
  #workTimeTbl { width: 180px; }
  /* 출퇴근버튼 */
  #work-ban-container button { width: 160px; height: 50px; margin: 5px 0px; color: #fff; }
  /* 연차확인 */
  .roundBolder { width: 80px; height: 80px; border-radius: 50px; background-color: #BDDFFF; color: #fff; font-size: 32px; font-weight: bolder; }
  .smallRound { width: 30px; height: 30px; border-radius: 50px; background-color: #F3F7FA; color: #000000; font-size: 16px; font-weight: bolder; }
  #annualLeaveDiv { display: flex; text-align: center; align-items: center; }
  #annualLeaveDiv ul li { margin: 0 20px; }

  /* 근태조회 div */
  /* 조회 월 선택 */
  .year-month { font-size: 24px; font-weight: bolder; text-align: center; color: black; }
  .sec_cal { width: 100%; margin: 0 auto; font-family: "NotoSansR"; }
  .sec_cal .cal_nav { display: flex; justify-content: center; align-items: center; font-weight: 700; font-size: 48px; line-height: 72px; }
  .sec_cal .cal_nav .year-month { width: 300px; text-align: center; line-height: 1; }
  .sec_cal .cal_nav .nav { display: flex; border: 1px solid #333333; border-radius: 5px; }
  .sec_cal .cal_nav .go-prev, .sec_cal .cal_nav .go-next { display: block; width: 50px; height: 78px; font-size: 0; display: flex; justify-content: center; align-items: center; }
  .sec_cal .cal_nav .go-prev::before, .sec_cal .cal_nav .go-next::before { content: ""; display: block; width: 20px; height: 20px; border: 3px solid #000; border-width: 3px 3px 0 0; transition: border 0.1s; }
  .sec_cal .cal_nav .go-prev:hover::before, .sec_cal .cal_nav .go-next:hover::before { border-color: var(--main-color-dk); }
  .sec_cal .cal_nav .go-prev::before { transform: rotate(-135deg); }
  .sec_cal .cal_nav .go-next::before { transform: rotate(45deg); }
  .cal_tblDiv { display: flex; flex-direction: column; align-items: flex-start; }
  .go-up>a::before, .go-down>a::before { content: ""; display: block; width: 10px; height: 10px; border: 2px solid #000; border-width: 3px 3px 0 0; transition: border 0.1s; margin-top: 5px;}
  .weekDiv { font-size: 24px; font-weight: bolder; width: 80px; justify-content: space-between; }
  .go-up>a:hover::before, .go-down>a:hover::before { border-color: var(--main-color-dk); }
  .go-down>a::before { transform: rotate(135deg); }
  .go-up>a::before { transform: rotate(-45deg);}
  .cal_tbl { width: 95%; margin: 0px 20px; padding: 10px; border-collapse: collapse; }
  .cal_tbl td, .cal_tbl th { border-bottom: 1px solid var(--border-color); padding: 8px; text-align: center; }
  .highlight-color>p,  .highlight-color>a {color: var(--main-color-dk);}
</style>

<section class="max1920px">
  <jsp:include page="/WEB-INF/views/common/side-nav.jsp" />

  <div class="main-section bgc-F8FCFF">
    <div class="section-shadow bgc-fff head-nav">
      <ul class="row" style="margin-left: 30px">
        <li>근태관리</li>
        <li>|</li>
        <li>내 출근부</li>
      </ul>
    </div>
    <div class="row section-shadow bgc-fff" id="workBoardDiv">
			<div id="nowDateDiv" class="column">
				<!-- 현재 시간 -->
				<c:set var="today" value="<%=new java.util.Date()%>" />
				<c:set var="dateFormat">
					<fmt:formatDate value="${today}" pattern="yyyy-MM-dd(E)" />
				</c:set>
				<div id="today" align="center">
					<c:out value="${dateFormat}" />
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
        <button>시간 수정 요청</button>
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
          <div class="year-month"><!-- 년월을 표시 --></div>
          <a href="#" class="go-next">next</a>
        </div>
        <input type="hidden" id="currentDate" value="">
        <div class="cal_tblDiv">
          <!-- 주차와 일자를 표시할 테이블들이 들어갈 위치 -->
        </div>
      </div>
    </div>
  </div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	// 페이지 로드 시 실행되는 함수
	$(document).ready(function() {
		// 현재 시간 출력
		printClock();
		// 캘린더 초기화
		calendarInit();

		// 현재 날짜를 ISO 8601 형식으로 변환하여 hidden input에 설정
		var currentDate = getISODateString();
		document.getElementById("currentDate").value = currentDate;
	});
	// JavaScript에서 현재 날짜를 ISO 8601 형식으로 변환하는 유틸리티 함수
	function getISODateString() {
		var currentDate = new Date();
		var year = currentDate.getUTCFullYear();
		var month = ('0' + (currentDate.getUTCMonth() + 1)).slice(-2);
		var day = ('0' + currentDate.getUTCDate()).slice(-2);
		var hours = ('0' + currentDate.getUTCHours()).slice(-2);
		var minutes = ('0' + currentDate.getUTCMinutes()).slice(-2);
		var seconds = ('0' + currentDate.getUTCSeconds()).slice(-2);
		return year + '-' + month + '-' + day + 'T' + hours + ':' + minutes
				+ ':' + seconds + 'Z';
	}

	// 현재 시간 출력하는 함수
	function printClock() {
		var clock = $("#clock");
		var currentDate = new Date(); // 현재시간
		var currentHours = addZeros(currentDate.getHours(), 2);
		var currentMinute = addZeros(currentDate.getMinutes(), 2);
		var currentSeconds = addZeros(currentDate.getSeconds(), 2);

		if (currentSeconds >= 50) { // 초가 50 이상일 때 빨간색으로 표시
			currentSeconds = '<span style="color:#de1951;">' + currentSeconds
					+ '</span>';
		}

		clock.html(currentHours + ":" + currentMinute + ":" + currentSeconds); // 시간을 출력
		setTimeout(printClock, 1000); // 1초마다 printClock() 함수 호출
	}

	// 자릿수를 맞추는 함수
	function addZeros(num, digit) {
		var zero = '';
		num = num.toString();
		if (num.length < digit) {
			for (var i = 0; i < digit - num.length; i++) {
				zero += '0';
			}
		}
		return zero + num;
	}

	// 주차 정보를 가져오는 함수
	function getWeekNumber(date) {
		// 해당 날짜 (일)
		const currentDate = date.getDate();
		// 이번 달 1일로 지정
		const startOfMonth = new Date(date.getFullYear(), date.getMonth(), 1);
		// 이번 달 1일이 무슨 요일인지 확인
		const weekDay = startOfMonth.getDay(); // 0: Sun ~ 6: Sat
		// ((요일 - 1) + 해당 날짜) / 7일로 나누기 = N 주차
		// console.log(parseInt(((weekDay - 1) + currentDate) / 7) + 1);
		return parseInt(((weekDay - 1) + currentDate) / 7) + 1;
	}
	
	function fetchWorkData(currentYear, currentMonth) {
	    $.ajax({
	      url: 'workTime.do',
	      method: "GET",
	      data: {
	    	  	currentYear:currentYear,
	    		currentMonth:currentMonth},
	      dataType: "json",
	      success: function(data) {
	        // 데이터를 가져온 후 테이블에 출력
	        renderCalendarTable(data);
	      },
	      error: function(err) {
	        console.error("Error fetching data: " + err.statusText);
	      }
	    });
	  }

	// 캘린더 테이블을 생성하는 함수
	function renderCalendarTable(data) {
		 // 렌더링을 위한 데이터 정리
		
		var startDate = new Date(currentYear, currentMonth, 1);
		var endDate = new Date(currentYear, currentMonth + 1, 0);
		var currentDate = new Date(startDate);

        var currentYearMonth = currentYear + "" +(currentMonth+1);
        var monthSWeek = startDate.getDay();
        var weekSeq = parseInt((parseInt(endDate) + monthSWeek - 1)/7)+1;
        
		var monthLabel = currentYear + "-"
				+ (currentMonth + 1).toString().padStart(2, "0");
		$(".year-month").text(monthLabel);
		

		var table = $("<table>").addClass("cal_tbl weekTable")
				.attr("id", "calenderTable");
		var tableHeader = $("<tr>").addClass("tableHeader");

		var headerLabels = [ "일자", "출근시간", "퇴근시간", "근무시간", "초과시간" ];
		for (var i = 0; i < headerLabels.length; i++) {
			var th = $("<th>").text(headerLabels[i]);
			tableHeader.append(th);
		}

		table.append(tableHeader);

		var currentWeek = getWeekNumber(startDate);
		var weekDiv = $("<div>").addClass("row weekDiv go-down");
		var weekHeader = $("<p>").addClass("weekNumber").text(
				currentWeek + "주차");
		var collapseIcon = $("<a>").attr("href", "#");
		/*  var weekTable = table.clone(); */
		var weekTable = $(".weekTable[data-week='" + currentWeek + "']"); // 이미 생성된 주차 테이블인지 확인

		if (!weekTable.length) {
			weekTable = table.clone().addClass("weekTable").attr("data-week",
					currentWeek); // 주차 테이블 클래스와 데이터 속성 추가
			weekTable.hide(); // 새로 생성된 주차 테이블은 숨김 상태로 생성
			weekDiv.append(weekHeader);
			weekDiv.append(collapseIcon);
			$(".cal_tblDiv").append(weekDiv);
		}

	
		var week = [ '일', '월', '화', '수', '목', '금', '토' ];
		while (currentDate <= endDate) {
			var tr = $("<tr>");
			var dayOfWeek = currentDate.getDay();
			var dayLabel = week[dayOfWeek];
			var tdDate = $("<td>").text(currentDate.getDate() + " " + dayLabel);
			var tdWorkStart = $("<td>").text(formatTime(data[currentYearMonth][currentDate.getDate()].workStart));
		    var tdWorkEnd = $("<td>").text(formatTime(data[currentYearMonth][currentDate.getDate()].workEnd));
			var tdWorkHours = $("<td>").text("0");
			var tdOvertimeHours = $("<td>").text("0");
			tr.append(tdDate);
			tr.append(tdWorkStart);
			tr.append(tdWorkEnd);
			tr.append(tdWorkHours);
			tr.append(tdOvertimeHours);
	
			weekTable.append(tr);
	
			currentDate.setDate(currentDate.getDate() + 1);
	
			var nextWeek = getWeekNumber(currentDate);
			if (nextWeek !== currentWeek) {
				weekTable.hide();
				$(".cal_tblDiv").append(weekDiv);
				$(".cal_tblDiv").append(weekTable);
	
				currentWeek = nextWeek;
				weekDiv = $("<div>").addClass("row weekDiv go-down");
				weekHeader = $("<p>").addClass("weekNumber").text(
						currentWeek + "주차");
				collapseIcon = $("<a>").attr("href", "#");
				weekTable = table.clone();
	
				weekDiv.append(weekHeader);
				weekDiv.append(collapseIcon);
				weekDiv.on("click", function() {
					weekTable.toggle();
				});
			}
		}

	}

	function formatTime(timeString) {
	    if (!timeString) {
	      return "미등록";
	    }

	    var time = timeString.split(":");
	    var hours = parseInt(time[0], 10);
	    var minutes = parseInt(time[1], 10);
	    var seconds = parseInt(time[2], 10);

	    return (hours < 10 ? "0" : "") + hours + ":" +
	           (minutes < 10 ? "0" : "") + minutes + ":" +
	           (seconds < 10 ? "0" : "") + seconds;
	  }

	// 캘린더 초기화 함수
	function calendarInit() {

		// 최초 페이지 로드 시 현재 월 표시
		var today = new Date();
		var currentYear = today.getFullYear();
		var currentMonth = today.getMonth();
		var monthLabel = currentYear + "-"
				+ (currentMonth + 1).toString().padStart(2, "0");
		$(".year-month").text(monthLabel); // 현재 월 표시

		fetchWorkData(currentYear, currentMonth,'user01');

		var currentWeekTable = null;

		// 이전 달로 이동하는 버튼
		$('.go-prev').on('click', function() {
			$(".cal_tblDiv").empty();
			currentMonth--;
			if (currentMonth < 0) {
				currentYear--;
				currentMonth = 11;
			}
			$('#calenderTable').remove();
			fetchWorkData(currentYear, currentMonth);

			if (currentWeekTable) {
				currentWeekTable.hide();
				currentWeekTable = null;
			}
		});

		// 다음 달로 이동하는 버튼
		$('.go-next').on('click', function() {
			$(".cal_tblDiv").empty();
			currentMonth++;
			if (currentMonth > 11) {
				currentYear++;
				currentMonth = 0;
			}
			$('#calenderTable').remove();
			fetchWorkData(currentYear, currentMonth);

			if (currentWeekTable) {
				currentWeekTable.hide();
				currentWeekTable = null;
			}
		});

		// 주차 정보를 표시하는 div를 클릭했을 때 해당 주차 테이블 열고 닫기
		$(document).on(
				'click',
				'.weekDiv',
				function() {
					var weekTable = $(this).next();
					//console.log(weekTable);
					// 다른 주차 테이블들 닫기
					$(".weekTable").not(weekTable).hide();
					$(".weekDiv").not($(this)).removeClass(
							"highlight-color go-up").addClass("go-down");

					if (weekTable.is(":visible")) {
						// 주차 테이블이 열려있을 때 닫기
						weekTable.hide();
						$(this).removeClass("highlight-color go-up").addClass(
								"go-down");
					} else {
						// 주차 테이블이 닫혀있을 때 열기
						weekTable.show();
						$(this).addClass("highlight-color go-up").removeClass(
								"go-down");
					}
				});

	}
</script>