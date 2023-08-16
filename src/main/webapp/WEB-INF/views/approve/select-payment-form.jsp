<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <section>
	<div class="approve hidden-approve">
	  <div class="bg-approve"></div>
	  <div class="modalBox-approve">
	  		<span id="form-choice-name">결재양식 선택</span>
	  		<div id="form-flex">
	  			<div id="form-choice">
	  				<div id="form-column">
		  				<a onclick="extendsApply();">연장근무신청</a>
		  				<a onclick="attendanceApply();">근태신청</a>
		  				<a onclick="expenditureApply();">지출결의서신청</a>
	  				</div>
	  			</div>
	  			<div id="form-choice-result">
	  				<img src="${path}/resources/images/approve/default.png" height="400px" width="250px"> 
	  			</div>
	  		</div>
	  		
			<button type="button" id="approval-close-button">닫기</button>
			<button type="button" id="approval-write-button" onclick="approvalWrite();">작성</button>
	  </div>
	</div>
</section>  
<link rel="stylesheet" href="${path}/resources/css/approve/select-payment-form.css">
<script src="${path}/resources/js/approve/select-payment-form.js"></script>


  