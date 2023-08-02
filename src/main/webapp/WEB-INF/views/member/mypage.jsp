<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="${path}/resources/css/member/mypage.css">
<section class="max1920px">
<jsp:include page="/WEB-INF/views/common/side-nav.jsp"/>

<section class="mypage-section">
	<div class="main-section section-shadow card profile-info">
		<div class="right-container">
				<h2>프로필</h2>
				<img src="${path }/resources/upload/profile/${loginMember.profileImg}" id="mypage-profile" onclick="fn_updateProfile();">
				<form action="${path }/member/profile" method="post" enctype="multipart/form-data" id="profile-form">
					<input type="file" name="profileImg" id="profile-input" accept="image" required>
					<div>
						<input type="reset" value="취소" onclick="fn_resetProfile();">
						<button onclick="fn_profileSubmit();">수정</button>
					</div>
				</form>
				<p>${loginMember.memberName } 님</p>
				<div>
					<p>부서</p>
					<input type="text" value="${loginMember.dept.deptName }" disabled>
					<p>직책</p>
					<input type="text" value="${loginMember.job.jobName }" disabled>
					<p>급여</p>
					<input type="text" value="${loginMember.salary }" disabled>
					<p>입사일</p>
					<input type="date" value="${loginMember.hireDate }" disabled>
				</div>
			</div><!-- right-container -->
		</div><!-- profile-info -->
		<div class="mypage-update-div">
			<div class="main-section section-shadow card">
				<div class="right-container">
					<h2>개인 정보 수정</h2>
					<form action="${path }/member/info" method="post" id="member-update-form">
						<input type="hidden" name="memberId" value="${loginMember.memberId}">
						<div class="mypage-update">
							<span>전화번호</span>
							<input type="text" name="phone" value="${loginMember.phone }" required>
							<p>* 전화번호 입력 시 하이픈(-) 제외하고 입력하세요.</p>
						</div>
						<div class="mypage-update">
							<span>이메일</span>
							<input type="email" name="email" value="${loginMember.email }" required>
							<button onclick="fn_requestEmail();">인증 요청</button>
						</div>
						<!-- 인증 요청 버튼을 누르면 보일 구간 -->
						<div class="mypage-update">
							<span>인증 번호</span>
							<input type="text" name="email_check_number">
							<button onclick="fn_checkEmailNumber();">인증</button>
						</div>
						<!--  -->
						<div class="mypage-update">
							<span>주소 검색</span>
							<input type="text" name="mainAddress" value="${loginMember.address }" required>
							<button onclick="fn_searchAddr();">검색</button>
						</div>
						<div class="mypage-update">
							<span>상세 주소</span>
							<input type="text" name="detailAddress" value="${loginMember.subAddress }" required>
						</div>
						<div class="mypage-update">
							<span>변경 사유</span> <input type="text" name="updateComment" required>
						</div>
						<div>
							<h4>수정 요청 현황</h4>
							<table class="update-result-tb">
								<tr>
									<th>신청자</th>
									<th>승인 담당자</th>
									<th class="tb-content">신청 사유</th>
									<th>신청 날짜</th>
									<th>처리 결과</th>
								</tr>
								<tr>
									<td colspan="5"><hr /></td>
								</tr>
								<c:if test="${not empty approv }">
									<tr>
										<td>${approv.memberId }</td>
										<td>${approv.approvalMember }</td>
										<td>${approv.updateComment }</td>
										<td>${approv.requestDate }</td>
										<td>${approv.approvalFl=='N'?"미승인":"승인완료" }</td>
									</tr>
									<tr>
										<td colspan="5"><hr /></td>
									</tr>
								</c:if>
								<c:if test="${empty approv }">
									<tr>
										<td colspan="5">수정 요청한 내역이 없습니다.</td>
									</tr>
									<tr>
										<td colspan="5"><hr /></td>
									</tr>
								</c:if>
							</table>
						</div>
					</form>
					<div class="mypage-update">
						<input type="reset" value="취소">
						<button onclick="fn_updateMember();">수정 요청</button>
					</div>
					<p>* 개인정보 수정 요청 시, 인사팀에서 승인 후 변경 사항이 적용됩니다.</p>
					</div>
				</div>
				<div class="main-section section-shadow card">
					<form action="" method="" id="pwd-update-form">
						<div class="right-container">
							<h2>비밀번호 수정</h2>
							<div class="mypage-update">
								<span>현재 비밀번호</span>
								<input type="password" name="oriPwd" id="ori-pwd">
							</div>
							<div class="mypage-update">
								<span>새 비밀번호</span>
								<input type="password" name="newPwd" id="new-pwd">
							</div>
							<div class="mypage-update">
								<span>비밀번호 확인</span>
								<input type="password" id="pwd-check">
							</div>
						</div>
					</form>
					<div>
						<input type="reset" value="취소">
						<button onclick="fn_updatePwd();">수정</button>
					</div>
			</div>
		</div>
	</section>
</section><!-- max1920px -->
<script>
	//프로필 사진 변경
	function fn_updateProfile(){
		$("#profile-input").click();
		$("#profile-input").change(()=>{
			const fileName=$("#profile-input")[0].files[0].name;
			const fileSrc=URL.createObjectURL($("#profile-input")[0].files[0]);
			$("#mypage-profile").attr("src",fileSrc);
		});
	}
	
	//프로필 취소
	function fn_resetProfile(){
		$("#profile-input").val('');
		$("#mypage-profile").attr("src","${path }/resources/upload/profile/${loginMember.profileImg}");
	}
	
	function fn_profileSubmit(){
		if($("#profile-input").val()!=''){
			$("#profile-form").submit();
		}else{
			alert("변경할 이미지를 업로드하세요.");
			fn_updateProfile();
		}
	}
	
	//개인 정보 수정
	function fn_updateMember(){
		console.log("${approv}");
		if("${approv}"!=""){
			alert("미승인된 요청 정보가 있습니다.");
			locatiob.reload();
		}else{
			$("#member-update-form").submit();
		}
	}
</script>
</body>
</html>