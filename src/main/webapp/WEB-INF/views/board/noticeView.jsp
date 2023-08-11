<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- 기존 스타일 유지 -->
<style>
   /* 기본 스타일링 */
  .row { display: flex; flex-direction: row; }
  .column { display: flex; flex-direction: column; }
  .center { display: flex; align-items: center; justify-content: center; text-align: center; }
  .padding10px{padding: 10px;}
  .margin10px{margin: 10px;}
  .flexSpace{display:flex;align-items: center;justify-content: space-between; }

  /* 색상 설정 */
  .bgc-fff { background-color: #fff; }
  .bgc-F8FCFF { background-color: #F8FCFF; }
  .hrstyle{border-bottom:solid 1px #e0e0e0;}

  /* 게시판 헤더 */
  .head-nav { height: 56px; display: flex; align-items: center; padding-left: 30px; }
  .head-nav ul li { margin: 0px 5px; }

  /* 상세화면 스타일 */
  #noticeDetailDiv { margin: 60px 20px; padding: 20px; border-radius: 5px; }
  #noticeTitle { font-size: 24px; font-weight: bold; margin-bottom: 20px; }
  #noticeContent { white-space: pre-line; margin-top: 20px; }
  #noticeWriter, #noticeDate,#noticeViewCount { font-size: 14px; color: #888888; }
  
  /* 댓글 영역 스타일 */
  #commentSection { margin-top: 30px; border-top: 1px solid #e0e0e0; padding-top: 20px; }
  #commentList { margin-top: 20px; }
  .commentItem { border-bottom: 1px dashed #e0e0e0; padding: 10px 0; }
  .recommentItem {padding: 10px 0; }
  .commentWriter, .commentDate, .recommentWriter, .recommentDate { font-size: 14px; color: #888888; }
  .commentContent,.recommentContent { margin-top: 10px; }
  .replySection{margin:10px; display: flex;}
  .replySection button{margin-left: 10px; }
  
  /* 버튼스타일 */
  button{cursor: pointer; }
  .prevAndNext{display: flex;justify-content: space-evenly;}
  .btnSimple{border: solid 1px #e0e0e0;background-color:#fff; }
  .btnSimple:hover{color:var(--main-color-dk);background-color:#fff;}
  #submitCommentBtn{margin: 010px; height: 50px;}
  .listAndUpdateAndDelete{display: flex;justify-content: space-between;margin: 0 10px;}
</style>

<section class="max1920px">
    <jsp:include page="/WEB-INF/views/common/side-nav.jsp" />
    <div class="main-section bgc-F8FCFF">        
        <div class="section-shadow bgc-fff head-nav">
            <ul class="row">
                <li>게시판</li>
                <li>|</li>
                <li>공지사항 상세</li>
            </ul>
        </div>
        <div class="section-shadow bgc-fff padding10px">
            <div id="noticeDetailDiv" class="column hrstyle">
	            <div>
	                <div id="noticeTitle">태풍 '카눈' 북상 관련 전사공지</div>
	            </div>
	            <div class="row hrstyle">
	                <div id="noticeWriter" class="margin10px">김사원</div>
	                <div id="noticeDate" class="margin10px">23.08.10</div>
	                <div id="noticeViewCount" class="margin10px">조회수 27</div>
	            </div>
                <div id="noticeContent">
                    태풍 [카눈] 상륙으로 인한 업무시간을 아래와 같이 안내합니다.

					1. 일        시 : 2023.8.10.(목)
					2. 업무시간 : 오후 1시부터 업무 시작
					
					※ 태풍 관련 안전사고에 유의하시기 바랍니다.
                </div>
            </div>
            <div class="btnContainer">
	            <div class="prevAndNext">
	            	<div class="margin10px">
	                	<button id="prevBtn" class="btnSimple">이전글</button>
	                	<span>직원 휴게실 이용 안내사항</span>
	            	</div>
	            	<hr>
	            	<div class="margin10px">
	                	<span>다음글이 없습니다.</span>
	                	<button id="nextBtn" class="btnSimple">다음글</button>
	            	</div>
	            </div>
	            <div class="listAndUpdateAndDelete">
	            	<div>
		                <button id="listBtn" class=" btnSimple">목록</button>
	            	</div>
	                <div>
		                <button id="updateBtn" class="margin10px btnSimple">수정</button>
		                <button id="deleteBtn" class=" btnSimple">삭제</button>
	                </div>
	            </div>
            </div>
        </div>
        <div id="commentSection" class="section-shadow bgc-fff padding10px">
		    <div class="center">
		        <textarea id="commentTextarea" placeholder="댓글을 작성하세요..." rows="3" cols="80"></textarea>
		        <button id="submitCommentBtn">등록</button>
		    </div>
			    <!-- 댓글 리스트 출력 -->
			    <div id="commentList">
			        <div class="commentItem">
				        <div class="flexSpace">
				        	<div>
					            <span class="commentWriter">김댓글</span>
					            <span class="commentDate">23.08.10 07:30</span>
					            <div class="commentContent">
					                공지사항 감사합니다. 참고하겠습니다.
					            </div>
				        	</div>
				        	<div>
					            <button class="replyBtn btnSimple">답글</button>
					            <button class="replyUpdateBtn btnSimple">수정</button>
					            <button class="replyDeleteBtn btnSimple">삭제</button>
				        	</div>
				        </div>
			            <!-- 대댓글 작성 영역 -->
			            <div class="replySection" style="margin-left: 20px; display: none;">
			                    <textarea placeholder="답글을 작성하세요..." rows="2" cols="70"></textarea>
			                    <button class="submitReplyBtn">등록</button>
			            </div>
			             <!-- 대댓글 영역 시작 -->
			            <div class="replyList" style="margin-left: 20px;">
			                <div class="recommentItem">
			                    <span class="recommentWriter">이대댓글</span>
			                    <span class="recommentDate">23.08.10 08:30</span>
			                    <div class="recommentContent">
			                        감사합니다.
			                    </div>
			                    <div>
				            		<button class="replyUpdateBtn btnSimple">수정</button>
					           		<button class="replyDeleteBtn btnSimple">삭제</button>
			        			</div>
			                </div>
			            </div>
			        </div>
		        </div>
		        <div class="commentItem">
			        <div class="flexSpace">
			        	<div>
				            <span class="commentWriter">강팀장</span>
				            <span class="commentDate">23.08.10 11:30</span>
				            <div class="commentContent">
				                아나 이걸 지금 보다니
				            </div>
			        	</div>
			        	<div>
				            <button class="replyBtn btnSimple">답글</button>
				            <button class="replyUpdateBtn btnSimple">수정</button>
					            <button class="replyDeleteBtn btnSimple">삭제</button>
			        	</div>
			        </div>
		        		<!-- 대댓글 작성 영역 -->
			            <div class="replySection" style="margin-left: 20px; display: none;">
			                    <textarea placeholder="답글을 작성하세요..." rows="2" cols="70"></textarea>
			                    <button class="submitReplyBtn">등록</button>
			            </div>
		        </div>
		    </div>
		</div>
</section>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    $('.replyBtn').on('click', function() {
        var replySection = $(this).parent().parent().next('.replySection');
        replySection.toggle();
    });
});

</script>

</body>
</html>
