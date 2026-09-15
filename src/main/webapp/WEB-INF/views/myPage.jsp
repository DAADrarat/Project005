<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 - 전체일정</title>

<!-- 1. FullCalendar v6 라이브러리 불러오기 -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project.css" type="text/css" />
<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/loginSide.css" type="text/css" />

</head>
<body>

	<jsp:include page="/WEB-INF/views/header.jsp" />
	<jsp:include page="/WEB-INF/views/side.jsp" />

	<div class="sub-title-wrap">
		<div>마이페이지</div>
	</div>

	<div class="inner">

		<!-- 달력 범례 -->
		<div class="board-calendar-tab">
			<div class="b-cal-cate-box">
				<ul>
					<li id="b-policy"><span>정부사업일정</span></li>
					<li id="b-cert"><span>자격증일정</span></li>
					<li id="b-job"><span>채용공고일정</span></li>
				</ul>
			</div>
		</div>

		<!-- 캘린더 영역 -->
		<div id="calendar"></div>

		<!-- 내 신청내역 -->
		<div class="policy-section">
			<div class="policy-left">
				<div>
					<div class="policy-header-flex">
						<h3>내 신청내역</h3>
					</div>
					<ul class="policy-list">
						<c:forEach var="e" items="${events}">
							<li>
								<span>
									<span class="badge badge-${e.allpcj}">
										<c:choose>
											<c:when test="${e.allpcj == 'POLICY'}">정부사업</c:when>
											<c:when test="${e.allpcj == 'CERT'}">자격증</c:when>
											<c:otherwise>채용공고</c:otherwise>
										</c:choose>
									</span>
									${e.title}
									<em class="d-date">${e.startDate}</em>
								</span>
								<!-- code 자리에 신청내역 PK 가 들어있어서 그대로 취소에 사용 -->
								<form method="post"
									action="${pageContext.request.contextPath}/cancelApply.do">
									<input type="hidden" name="type" value="${e.allpcj}">
									<input type="hidden" name="appId" value="${e.code}">
									<button type="submit" class="cancel-btn">신청취소</button>
								</form>
							</li>
						</c:forEach>
						<c:if test="${empty events}">
							<li class="empty-msg">신청한 일정이 없습니다. 일정 캘린더에서 관심 항목을 체크해 보세요.</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>

	</div>

	<script>
        document.addEventListener('DOMContentLoaded', function() {
            const calendarEl = document.getElementById('calendar');

            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                initialDate: '2026-09-01',
                locale: 'ko',

                headerToolbar: {
                    left: 'prev',
                    center: 'title',
                    right: 'next'
                },

                displayEventTime: false,

                // 내가 신청한 일정 (allpcj 로 종류별 색 구분)
                events: [
                    <c:forEach var="e" items="${events}" varStatus="st">
                        {
                            title: '${e.title}',
                            start: '${e.startDate}'
                            <c:if test="${not empty e.endDate}">, end: '${e.endDate}'</c:if>
                            , color: '${e.allpcj == "POLICY" ? "#ffe4e8" : (e.allpcj == "CERT" ? "#ffc107" : "#e4eeff")}'
                            , textColor: '${e.allpcj == "POLICY" ? "#d63353" : (e.allpcj == "CERT" ? "#000000" : "#1e3a8a")}'
                        }<c:if test="${!st.last}">,</c:if>
                    </c:forEach>
                ]
            });

            calendar.render();
        });
    </script>

</body>
</html>
