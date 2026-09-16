<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>마이페이지 - 정부사업일정</title>

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
		<div>정부사업일정</div>
	</div>

	<div class="inner">
		<!-- 상단 탭 -->
		<div class="pc-tab">
			<ul class="tab-ul01">
				<li><a href="${pageContext.request.contextPath}/calendarAll.do"><span>전체일정</span></a></li>
				<li class="active"><a
					href="${pageContext.request.contextPath}/calendarPolicy.do"><span>정부사업일정</span></a></li>
				<li><a
					href="${pageContext.request.contextPath}/calendarCertification.do"><span>자격증시험일정</span></a></li>
				<li><a href="${pageContext.request.contextPath}/calendarJob.do"><span>채용공고일정</span></a></li>
			</ul>
		</div>

		<!-- 달력 범례 -->
		<div class="board-calendar-tab">
			<div class="b-cal-cate-box">
				<ul>
					<li class="b-bachelor"><span>정부사업일정</span></li>
				</ul>
			</div>
		</div>

		<div id="calendar"></div>

		<!-- 정책 리스트 영역 -->
		<form method="post"
			action="${pageContext.request.contextPath}/applyPolicy.do">
			<div class="policy-section">
				<div class="policy-left">
					<div>
						<div class="policy-header-flex">
							<h3>관심 정책 선택</h3>
							<div class="search-box-crappy">
								<input type="text" id="searchKeyword" placeholder="정책 검색...">
								<button type="button" id="searchBtn">조회</button>
							</div>
						</div>
						
						<ul class="policy-list" id="policyList">
							<c:forEach var="p" items="${policyList}">
								<li><a href="#" title="${p.govProjectInfo}">${p.govProjectName}</a>
									<input type="checkbox" value="${p.govProjectCode}"
									data-label="${p.govProjectName}">
								</li>
							</c:forEach>
							<c:if test="${empty policyList}">
								<li class="empty-msg">등록된 정부사업 일정이 없습니다.</li>
							</c:if>
						</ul>
					</div>
				</div>

				<div class="policy-right">
					<div>
						<div class="policy-header-flex">
							<h3>내가 선택한 정책</h3>
						</div>
						<ul id="selected-policies">
							<li class="empty-msg">선택된 정책이 없습니다. 왼쪽에서 체크해주세요.</li>
						</ul>
					</div>
					<button type="submit" class="checkout-btn">선택한 정책 신청하기</button>
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

                headerToolbar: {
                    left: 'prev',
                    center: 'title',
                    right: 'next'
                },

                eventBackgroundColor: '#ffe4e8',
                eventTextColor: '#d63353',
                displayEventTime: false,

                // DB에서 조회한 정부사업 일정 (컨트롤러의 model "events")
                events: [
                    <c:forEach var="e" items="${events}" varStatus="st">
                    {
                        title: '${e.title}',
                        start: '${e.startDate}'
                        <c:if test="${not empty e.endDate}">, end: '${e.endDate}'</c:if>
                    }<c:if test="${!st.last}">,</c:if>
                    </c:forEach>
                ]
            });

            calendar.render();
        });


        // ===== 여기부터 정책 목록 =====

        const listEl       = document.getElementById('policyList');
        const selectedList = document.getElementById('selected-policies');

        // 체크한 항목 기억 (검색해서 목록이 바뀌어도 유지)
        // key = govProjectCode, value = 정책 이름
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


        // 오른쪽 "내가 선택한 정책" 다시 그리기
        function renderSelected() {
            if (selected.size === 0) {
                selectedList.innerHTML = '<li class="empty-msg">선택된 정책이 없습니다. 왼쪽에서 체크해주세요.</li>';
                return;
            }

            selectedList.innerHTML = '';
            selected.forEach(function(label, value) {
                const li = document.createElement('li');
                li.textContent = label;

                // 실제로 서버에 넘어가는 값
                const hidden = document.createElement('input');
                hidden.type  = 'hidden';
                hidden.name  = 'govProjectCode';
                hidden.value = value;
                li.appendChild(hidden);

                selectedList.appendChild(li);
            });
        }


        // ===== 검색 =====

        async function searchPolicy() {
            const keyword = document.getElementById('searchKeyword').value.trim();
            const url = '${pageContext.request.contextPath}/searchPolicy.do?keyword='
                      + encodeURIComponent(keyword);

            const res  = await fetch(url);
            const list = await res.json();

            if (list.length === 0) {
                listEl.innerHTML = '<li class="empty-msg">검색 결과가 없습니다.</li>';
                return;
            }

            listEl.innerHTML = list.map(function(p) {
                return '<li>'
                     + '<a href="#" title="' + (p.govProjectInfo || '') + '">' + p.govProjectName + '</a>'
                     + '<input type="checkbox" value="' + p.govProjectCode + '"'
                     + ' data-label="' + p.govProjectName + '"'
                     + (selected.has(p.govProjectCode) ? ' checked' : '')
                     + '>'
                     + '</li>';
            }).join('');
        }

        document.getElementById('searchBtn')
                .addEventListener('click', searchPolicy);

        // 엔터로도 검색 
        document.getElementById('searchKeyword')
                .addEventListener('keydown', function(ev) {
                    if (ev.key === 'Enter') {
                        ev.preventDefault();
                        searchPolicy();
                    }
                });
    </script>

</body>
</html>
