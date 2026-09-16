<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 - 채용공고일정</title>

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
		<div>채용공고일정</div>
	</div>

	<div class="inner">
		<!-- 상단 탭 -->
		<div class="pc-tab">
			<ul class="tab-ul01">
				<li><a href="${pageContext.request.contextPath}/calendarAll.do"><span>전체일정</span></a></li>
				<li><a
					href="${pageContext.request.contextPath}/calendarPolicy.do"><span>정부사업일정</span></a></li>
				<li><a
					href="${pageContext.request.contextPath}/calendarCertification.do"><span>자격증시험일정</span></a></li>
				<li class="active"><a
					href="${pageContext.request.contextPath}/calendarJob.do"><span>채용공고일정</span></a></li>
			</ul>
		</div>

		<!-- 달력 범례 -->
		<div class="board-calendar-tab">
			<div class="b-cal-cate-box">
				<ul>
					<li class="b-bachelor" id="b-bachelor-1"><span>채용공고일정</span></li>
				</ul>
			</div>
		</div>

		<div id="calendar"></div>

		<!-- 채용 공고 리스트 영역 -->
		<form id="applyForm" method="post"
			action="${pageContext.request.contextPath}/applyJob.do">
			<div class="policy-section">
				<div class="policy-left">
					<div>
						<div class="policy-header-flex">
							<h3>관심 채용공고 선택</h3>
							<div class="search-box-crappy">
								<input type="text" id="searchKeyword" placeholder="공고 검색...">
								<button type="button" id="searchBtn">조회</button>
							</div>
						</div>
						<ul class="policy-list" id="jobList">
							<c:forEach var="j" items="${jobList}">
								<li><a href="#" title="${j.recruitmentInfo}">${j.jobPostingName}</a>
									<input type="checkbox" value="${j.jobPostingCode}"
									data-label="${j.jobPostingName}"></li>
							</c:forEach>
							<c:if test="${empty jobList}">
								<li class="empty-msg">등록된 채용공고가 없습니다.</li>
							</c:if>
						</ul>
					</div>
				</div>

				<div class="policy-right">
					<div>
						<div class="policy-header-flex">
							<h3>내가 선택한 공고</h3>
						</div>
						<ul id="selected-policies">
							<li class="empty-msg">선택된 공고가 없습니다. 왼쪽에서 체크해주세요.</li>
						</ul>
					</div>
					<!--  button 을 submit 으로 변경-->
					<button type="submit" class="checkout-btn">선택한 공고 지원하기</button>
				</div>
			</div>
		</form>
	</div>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const calendarEl = document.getElementById('calendar');

			const calendar = new FullCalendar.Calendar(calendarEl, {
				initialView : 'dayGridMonth',
				initialDate : '2026-09-01',
				locale : 'ko',

				headerToolbar : {
					left : 'prev',
					center : 'title',
					right : 'next'
				},

				eventBackgroundColor : '#e4eeff',
				eventTextColor : '#1e3a8a',
				displayEventTime : false,

				// DB에서 조회한 채용공고 일정 (컨트롤러의 model "events")
				events : [
					<c:forEach var="e" items="${events}" varStatus="st">
					{
					    title : '${e.title}',
					    start : '${e.startDate}'
					    <c:if test="${not empty e.endDate}">, end : '${e.endDate}'</c:if>
					}<c:if test="${!st.last}">,</c:if>
					</c:forEach>
				]
			});

			calendar.render();
		});
		const listEl       = document.getElementById('jobList');
		const selectedList = document.getElementById('selected-policies');

		const selected = new Map();   // key = jobPostingCode, value = 공고 이름

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

		function renderSelected() {
		    if (selected.size === 0) {
		        selectedList.innerHTML = '<li class="empty-msg">선택된 공고가 없습니다. 왼쪽에서 체크해주세요.</li>';
		        return;
		    }

		    selectedList.innerHTML = '';
		    selected.forEach(function(label, value) {
		        const li = document.createElement('li');
		        li.textContent = label;

		        const hidden = document.createElement('input');
		        hidden.type  = 'hidden';
		        hidden.name  = 'jobPostingCode';
		        hidden.value = value;
		        li.appendChild(hidden);

		        selectedList.appendChild(li);
		    });
		}

		async function searchJob() {
		    const keyword = document.getElementById('searchKeyword').value.trim();
		    const url = '${pageContext.request.contextPath}/searchJob.do?keyword='
		              + encodeURIComponent(keyword);

		    const res  = await fetch(url);
		    const list = await res.json();

		    if (list.length === 0) {
		        listEl.innerHTML = '<li class="empty-msg">검색 결과가 없습니다.</li>';
		        return;
		    }

		    listEl.innerHTML = list.map(function(j) {
		        return '<li>'
		             + '<a href="#" title="' + (j.recruitmentInfo || '') + '">' + j.jobPostingName + '</a>'
		             + '<input type="checkbox" value="' + j.jobPostingCode + '"'
		             + ' data-label="' + j.jobPostingName + '"'
		             + (selected.has(j.jobPostingCode) ? ' checked' : '')
		             + '>'
		             + '</li>';
		    }).join('');
		}

		document.getElementById('searchBtn')
		        .addEventListener('click', searchJob);

		document.getElementById('searchKeyword')
		        .addEventListener('keydown', function(ev) {
		            if (ev.key === 'Enter') {
		                ev.preventDefault();
		                searchJob();
		            }
		        });
	</script>
	
	 <!-- 3. 공통 푸터 -->
     <jsp:include page="/WEB-INF/views/footer.jsp" /> 

</body>
</html>