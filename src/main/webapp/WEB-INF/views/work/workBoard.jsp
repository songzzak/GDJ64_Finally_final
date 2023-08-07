<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%!
public int getLastDay(int year, int month) {
  Calendar cal = Calendar.getInstance();
  cal.set(year, month - 1, 1);
  return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
}
%>

<% 
int year = Calendar.getInstance().get(Calendar.YEAR); // 현재 년도
int month = Calendar.getInstance().get(Calendar.MONTH) + 1; // 현재 월
int lastDay = getLastDay(year, month); // 해당 월의 마지막 날짜
%>
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
          <div class="year-month"></div>
          <a href="#" class="go-next">next</a>
        </div>
        <input type="hidden" id="currentDate" value="">
        <div class="cal_tblDiv">
         <table class="cal_tbl">
         	<thead>
         		<tr>
         			<th>일자</th>
         			<th>출근시간</th>
         			<th>퇴근시간</th>
         			<th>근무시간</th>
         			<th>초과시간</th>
         		</tr>
         	</thead>
         	<tbody>
         	<c:if test="${empty workList }">
         	<tr>
         		<td colspan="5">조회된 근무정보가 없습니다.</td>
         	</tr>
         	</c:if>
			<c:if test="${not empty workList }">
				<c:forEach var="workItem" items="${workList }">
					 <tr class="work-time-row">
		                <td>${workItem.workDate}</td>
		                <td>${workItem.workStart}</td>
		                <td>${workItem.workEnd}</td>
		                <td>${workItem.totalWorkTime}</td>
		                <td>${workItem.overtime}</td>
          			  </tr>
				</c:forEach>
			</c:if>
         	</tbody>
         </table>
        </div>
      </div>
    </div>
  </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 현재의 년도와 월
    var currentYear = new Date().getFullYear();
    var currentMonth = new Date().getMonth() + 1;
    $(".year-month").text(currentYear + "년 " + currentMonth + "월");
    // 현재 시간 출력
    printClock();

    $(".go-prev").on("click", function(e) {
        e.preventDefault();
        navigateMonth(-1);
    });

    $(".go-next").on("click", function(e) {
        e.preventDefault();
        navigateMonth(1);
    });
});

function navigateMonth(offset) {
    var dateParts = $(".year-month").text().split('년 ');
    var year = parseInt(dateParts[0].trim());
    var month = parseInt(dateParts[1].replace('월', '').trim());

    month += offset;
    if (month === 0) {
        month = 12;
        year--;
    } else if (month === 13) {
        month = 1;
        year++;
    }
    $(".year-month").text(year + "년 " + month + "월");
    //console.log(year);
    //console.log(month);

    $.get("workTime.do", {
        currentYear: year,
        currentMonth: month
    }, function (data) {
    	/* console.log(data);
    	console.log(data.workList);
    	console.log(data.workList.length); */
        $(".cal_tbl tbody").empty();
        if (!data || data.length == 0) {
            $(".cal_tbl tbody").append('<tr><td colspan="5">조회된 근무정보가 없습니다.</td></tr>');
        } else {
            $.each(data, function (index, workItem) {
                var rowHtml = '<tr class="work-time-row">';
                rowHtml += '<td>' + workItem.workDate + '</td>';
                rowHtml += '<td>' + workItem.workStart + '</td>';
                rowHtml += '<td>' + workItem.workEnd + '</td>';
                rowHtml += '<td>' + workItem.totalWorkTime + '</td>';
                rowHtml += '<td>' + workItem.overtime + '</td>';
                rowHtml += '</tr>';

                $(".cal_tbl tbody").append(rowHtml);
            });
        }
    });
}

	// 현재 시간을 출력하는 함수
	function printClock() {
		var clock = $("#clock");
		var currentDate = new Date(); //현재시간
		var currentHours = addZeros(currentDate.getHours(), 2);
		var currentMinute = addZeros(currentDate.getMinutes(), 2);
		var currentSeconds = addZeros(currentDate.getSeconds(), 2);

		if (currentSeconds >= 50) { // 50초 이상일 때 색을 변환해 준다.
			currentSeconds = '<span style="color:#de1951;">' + currentSeconds
					+ '</span>';
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


