<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 - 자격증시험일정</title>

<!-- 1. FullCalendar v6 라이브러리 불러오기 -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/project.css"
	type="text/css" />


</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" />

	<div class="sub-title-wrap">
		<div>자격증시험일정</div>
	</div>

	<div class="inner">
		<!-- 상단 탭 -->
		<div class="pc-tab">
			<ul class="tab-ul01">
				<li><a href="${pageContext.request.contextPath}/calendarAll.do"><span>전체일정</span></a></li>
				<li><a
					href="${pageContext.request.contextPath}/calendarPolicy.do"><span>정부사업일정</span></a></li>
				<li class="active"><a
					href="${pageContext.request.contextPath}/calendarCertification.do"><span>자격증시험일정</span></a></li>
				<li><a href="${pageContext.request.contextPath}/calendarJob.do"><span>채용공고일정</span></a></li>
			</ul>
		</div>

		<!-- 달력 범례 -->
		<div class="board-calendar-tab">
			<div class="b-cal-cate-box">
				<ul>
					<li class="b-bachelor" id="b-bachelor-1"><span>자격증일정</span></li>
				</ul>
			</div>
		</div>

		<div id="calendar"></div>

		<!-- 자격증 리스트 영역 -->

		<form action="${pageContext.request.contextPath}/applyCert.do"
			method="post">
			<div class="policy-section">
				<div class="policy-left">
					<div>
						<div class="policy-header-flex">
							<h3>관심 자격증 선택</h3>
							<div class="search-box-crappy">
								<input type="text" id="searchKeyword" placeholder="자격증 검색...">
								<button type="button" id="searchBtn">조회</button>
							</div>
						</div>
						<ul class="policy-list" id="certList">
							<c:forEach var="c" items="${certExamList}">
								<li><a href="https://www.example.com/${c.certCode}"
									target="_blank">${c.certName}</a> <!-- CERT_EXAM_APP_HISTORY의 PK가 (CERT_CODE, EXAM_SESSION) 복합키라 둘 다 넘김. '|'로 합쳐 보내고 컨트롤러에서 split -->
									<input type="checkbox" value="${c.certCode}|${c.examSession}"
									data-label="${c.certName}"></li>
							</c:forEach>
							<c:if test="${empty certExamList}">
								<li class="empty-msg">신청 가능한 자격증 일정이 없습니다.</li>
							</c:if>
						</ul>
					</div>
				</div>

				<div class="policy-right">
					<div>
						<div class="policy-header-flex">
							<h3>내가 선택한 자격증</h3>
						</div>
						<ul id="selected-policies">
							<li class="empty-msg">선택된 자격증이 없습니다. 왼쪽에서 체크해주세요.</li>
						</ul>
					</div>
					<button type="submit" class="checkout-btn">선택한 자격증 접수하기</button>
				</div>
			</div>
		</form>

	</div>

	<script>
	document.addEventListener('DOMContentLoaded', function() {
	    const calendarEl = document.getElementById('calendar');

	    const calendar = new FullCalendar.Calendar(calendarEl, {
	        initialView: 'dayGridMonth',
	        initialDate: '2026-09-01',
	        locale: 'ko',

	        headerToolbar: { left: 'prev', center: 'title', right: 'next' },

	        displayEventTime: false,

	        events: [
	            <c:forEach var="e" items="${events}" varStatus="st">
	                {
	                    title: '${e.title}',
	                    start: '${e.startDate}'
	                    <c:if test="${not empty e.endDate}">, end: '${e.endDate}'</c:if>
	                    , color: '#ffc107', textColor: '#000'
	                }<c:if test="${!st.last}">,</c:if>
	            </c:forEach>
	        ]
	    });

	    calendar.render();
	});


	// ===== 여기부터 자격증 목록 =====

	const listEl       = document.getElementById('certList');
	const selectedList = document.getElementById('selected-policies');

	// 체크한 항목 기억 (검색해서 목록이 바뀌어도 유지)
	// key = "certCode|examSession", value = 자격증 이름
	const selected = new Map();


	// 목록 전체에 한 번만 이벤트를 단다 (검색으로 새로 만들어진 체크박스도 잡힘)
	listEl.addEventListener('change', function(ev) {
	    const box = ev.target;
	    if (!box.matches('input[type="checkbox"]')) return;

	    if (box.checked) {
	        selected.set(box.value, box.dataset.label || box.value);
	    } else {
	        selected.delete(box.value);
	    }
	    renderSelected();
	});


	// 오른쪽 "내가 선택한 자격증" 다시 그리기
	function renderSelected() {
	    if (selected.size === 0) {
	        selectedList.innerHTML = '<li class="empty-msg">선택된 자격증이 없습니다. 왼쪽에서 체크해주세요.</li>';
	        return;
	    }

	    selectedList.innerHTML = '';
	    selected.forEach(function(label, value) {
	        const li = document.createElement('li');
	        li.textContent = label;

	        // 실제로 서버에 넘어가는 값
	        const hidden = document.createElement('input');
	        hidden.type  = 'hidden';
	        hidden.name  = 'examSession';
	        hidden.value = value;
	        li.appendChild(hidden);

	        selectedList.appendChild(li);
	    });
	}


	// ===== 검색 =====

	async function searchCert() {
	    const keyword = document.getElementById('searchKeyword').value.trim();
	    const url = '${pageContext.request.contextPath}/searchCert.do?keyword='
	              + encodeURIComponent(keyword);

	    const res  = await fetch(url);
	    const list = await res.json();

	    if (list.length === 0) {
	        listEl.innerHTML = '<li class="empty-msg">검색 결과가 없습니다.</li>';
	        return;
	    }

	    listEl.innerHTML = list.map(function(c) {
	        const value = c.certCode + '|' + c.examSession;
	        return '<li>'
	             + '<a href="#">' + c.certName + '</a>'
	             + '<input type="checkbox" value="' + value + '"'
	             + ' data-label="' + c.certName + '"'
	             + (selected.has(value) ? ' checked' : '')   // 아까 체크한 건 그대로 유지
	             + '>'
	             + '</li>';
	    }).join('');
	}

	document.getElementById('searchBtn')
	        .addEventListener('click', searchCert);

	// 엔터로도 검색 (form 안이라 submit 을 막아야 함)
	document.getElementById('searchKeyword')
	        .addEventListener('keydown', function(ev) {
	            if (ev.key === 'Enter') {
	                ev.preventDefault();
	                searchCert();
	            }
	        });
    </script>
    
     <!-- 3. 공통 푸터 -->
     <jsp:include page="/WEB-INF/views/footer.jsp" /> 

</body>
</html>