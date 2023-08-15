<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href='${path}/resources/fullcalender/main.min.css' rel='stylesheet' />
<script src='${path}/resources/fullcalender/main.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bPopup/0.11.0/jquery.bpopup.min.js"></script>
<style>
  /* 기본 스타일링 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }

  /* 색상 설정 */
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }

  /* 게시판 헤더 */
  .head-nav { height: 56px; display: flex; align-items: center; padding-left: 30px; }
  .head-nav ul li { margin: 0px 5px; }
  </style>
<section class="max1920px">
	<jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
    <div class="main-section bgc-F8FCFF">        
        <div class="section-shadow bgc-fff head-nav">
            <ul class="row">
                <li>회의실 예약</li>
                <li>|</li>
                <li>예약 목록</li>
            </ul>
        </div>
        <div class="section-shadow bgc-fff" style="padding: 30px;">
        	<select id="roomSelector" style="margin-bottom: 20px;">
                <option value="1">회의실 A</option>
                <option value="2">회의실 B</option>
                <option value="3">회의실 C</option>
          	</select>
          	<div>
          		<div class="row" style="align-items: center;">
          			<div style="background-color: red;width: 10px;height: 10px;border-radius: 50px;"></div><div>회의 종료</div>
          			<div style="background-color: green;width: 10px;height: 10px;border-radius: 50px;margin-left: 10px;"></div><div>회의 예정</div>
          		</div>
          	</div>
	        <div id='calendar'>
		        <!-- 회의실 예약 캘린더가 들어갈 위치 -->
	        </div>
	        <div id='popup' style="width:500px; height:300px; display:none; background-color:white; padding:20px; border-radius:14px; border:2px solid #eeeeee">
	        	<!-- 일정클릭 팝업창 -->
	        </div>
        </div>
	</div>
</section>
<script>
document.addEventListener('DOMContentLoaded', function () {

	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
      	locale: "ko",
         headerToolbar: {
             left: 'prev,next today',
             center: 'title',
             right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
         },
         editable: true,
         droppable: true, // this allows things to be dropped onto the calendar
         drop: function (arg) {
             // is the "remove after drop" checkbox checked?
             if (document.getElementById('drop-remove').checked) {
                 // if so, remove the element from the "Draggable Events" list
                 arg.draggedEl.parentNode.removeChild(arg.draggedEl);
             }
         },
         events: [],
         eventClick: function(info) {
             var eventData = info.event.extendedProps;
        	    var contents = "<div style='font-size:18px; margin-bottom:20px'>"
        	        + "제목 : " + eventData.popupTitle
        	        + "</div>"
        	        + "<div style='font-size:18px; margin-bottom:20px'>"
        	        + "예약시간 : " + eventData.time
        	        + "</div>"
        	        + "<div style='font-size:18px; margin-bottom:20px'>"
        	        + "예약자 : " + eventData.memberInfo
        	        + "</div>"
        	        + "<div style='font-size:18px; margin-bottom:20px'>"
        	        + "내용 : " + eventData.description
        	        + "</div>";

		 $("#popup").html(contents);
		 $("#popup").bPopup({
		speed: 650,
		transition: 'slideIn',
		transitionClose: 'slideBack',
		position: [($(document).width()-500)/2, 30] //x, y
		 });
		 info.jsEvent.stopPropagation();
		 info.jsEvent.preventDefault();
		          },
		          eventTimeFormat: {
		              hour: '2-digit',
		              minute: '2-digit',
		              hour12: false,
		              meridiem: false
		          },
		          displayEventTime: false // 시간 표시하지 않기
		      });

     calendar.render();


	function loadCalendar(roomValue) {
	    $.ajax({
	        url: "/meet/meetData?room=" + roomValue,
	        method: "GET",
	        dataType: "json",
	        success: function(data) {
	            calendar.removeAllEvents(); // 기존의 모든 이벤트를 제거합니다.
	            data.forEach(function(event) {
	                calendar.addEvent(event); // 새로운 이벤트를 추가합니다.
	            });
	        },
	        error: function(jqXHR, textStatus) {
	            alert( "Request failed: " + textStatus );
	        }
	    });
	}

	// 초기 로드시 기본 회의실 값으로 데이터를 불러옵니다.
	loadCalendar($('#roomSelector').val());
	
	$('#roomSelector').on('change', function() {
	    var selectedValue = $(this).val();
	    loadCalendar(selectedValue);
	});
});
</script>


</body>
</html>