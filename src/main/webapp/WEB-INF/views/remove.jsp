<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/loginSide.css" type="text/css" />
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" />
	
	<form action="removeAction.do" method="post">
		<div class="delete-card rounded-4 p-4 mx-auto mt-5" style="max-width: 480px;">
	        
	        <h4 class="fw-bold mb-4 text-center text-dark">회원 탈퇴</h4>
	        
	        <div class="delete-alert p-3 rounded-3 mb-4">
	            <strong class="text-danger">확인해 주세요</strong>
	            <p class="mb-0 mt-1 text small">
	                탈퇴 처리 시 계정 정보는 복구되지 않습니다
	            </p>
	        </div>
	
	        <form action="deleteUserAction.do" method="post">

	            <div class="mb-3">
	                <label class="form-label fw-bold text">비밀번호 확인</label>
	                <input type="password" name="userPw" class="form-control py-2" placeholder="현재 비밀번호를 입력하세요" required>
	            </div>
	
	            <div class="form-check mb-4">
	                <input class="form-check-input" type="checkbox" id="agreeCheck" required>
	                <label class="form-check-label text-muted small" for="agreeCheck">
	                    위 안내사항을 모두 확인하였으며 탈퇴에 동의합니다.
	                </label>
	            </div>
	
	            <div class="d-flex gap-2">
	                <a href="myPage.do" class="btn btn-cancel w-50 py-2 fw-bold text-decoration-none rounded-3 text-center">
	                    취소
	                </a>
	                <button type="submit" class="btn btn-delete w-50 py-2 fw-bold rounded-3">
	                    탈퇴 완료
	                </button>
	            </div>
	        </form>
	
	    </div>
	 </form>
	
</body>
</html>