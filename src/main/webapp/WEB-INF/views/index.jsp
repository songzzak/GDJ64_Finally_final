<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section class="max100per">
<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>
	<div class="main-section section-shadow">
		<div class="right-container">
			<h2 class="title">h2 title</h2>
			<select name="h-selectClassStatus">
                	<option>승인 상태(전체)</option>
                	<option value="Y">승인 완료</option>
                	<option value="N">승인 거절</option>
            </select>
            <button>확인</button>
			<div class="pageBar">
			  <ul class="pagination">
			    <li>
			      <a class="page-link" href="#">
			        <span>&laquo;</span>
			      </a>
			    </li>
			    <li class="active"><a class="page-link" href="#">1</a></li>
			    <li class="disabled"><a class="page-link" href="#">2</a></li>
			    <li class=""><a class="page-link" href="#">3</a></li>
			    <li class="">
			      <a class="page-link" href="#">
			        <span>&raquo;</span>
			      </a>
			    </li>
			  </ul>
			</div>
		</div>
	</div>
</section>


</body>
</html>