<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지-자격증</title>


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

	<jsp:include page="/WEB-INF/views/header.jsp" />

	<div class="container mt-5 text-center">
		<p class="fs-5 fw-bold mb-4">자격증 수집칸</p>

		<div
			class="d-flex justify-content-center flex-wrap gap-4 p-4 bg-light rounded shadow-sm"
			style="min-height: 150px;">
			<c:choose>
				<c:when test="${empty sessionScope.myCerts}">
					<div class="text-muted d-flex align-items-center">아직 수집한 뱃지가 없습니다. 아래 버튼을 눌러 자격증을 등록해 보세요!</div>
				</c:when>

				<%-- 수집한 뱃지가 있을 때 (반복문으로 이미지 출력) --%>
				<c:otherwise>
					<c:forEach var="cert" items="${sessionScope.myCerts}">
					    <div class="text-center">
					        
					        <img src="${pageContext.request.contextPath}/resources/images/${cert.certCode}.png" 
					             alt="${cert.certName}" 
					             style="width: 100px; height: 100px; object-fit: contain;">
					        
					        <div class="mt-2 fw-bold text-primary">${cert.certName}</div>
					    </div>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="container mt-5 text-center">
		<button type="button" class="btn btn-outline-primary btn-lg mt-3"
			data-bs-toggle="modal" data-bs-target="#certModal">자격증 등록하기
		</button>
	</div>

	<!-- 자격증 선택 모달 -->
	<div class="modal fade" id="certModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">보유 자격증</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<form action="${pageContext.request.contextPath}/saveCerts.do"
					method="post">
					<div class="modal-body">
						<p class="text-muted small">취득하신 자격증을 체크하시면 마이페이지에 뱃지가 해금됩니다.</p>
						<div class="row g-2">
							<!-- 자격증 체크박스들 -->
							<div class="col-6">
								<label><input type="checkbox" name="certCodes"
									value="EP1"> 측량및지형공간정보기사</label>
							</div>
							<div class="col-6">
								<label><input type="checkbox" name="certCodes"
									value="EP2"> 지적기사</label>
							</div>
							<div class="col-6">
								<label><input type="checkbox" name="certCodes"
									value="EP3"> 정보처리기사</label>
							</div>
							<div class="col-6">
								<label><input type="checkbox" name="certCodes"
									value="IP1"> 측량및지형공간정보산업기사</label>
							</div>
							<div class="col-6">
								<label><input type="checkbox" name="certCodes"
									value="IP2"> 지적산업기사</label>
							</div>
							<div class="col-6">
								<label><input type="checkbox" name="certCodes"
									value="IP3"> 정보처리산업기사</label>
							</div>
							<div class="col-6">
								<label><input type="checkbox" name="certCodes"
									value="HW1"> 한국사능력검정</label>
							</div>
							<div class="col-6">
								<label><input type="checkbox" name="certCodes"
									value="SW1"> SQLD</label>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">뱃지 수집하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>


</body>
</html>