<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- socket CDN -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.ownerVO" var="ownerVO"/>
</sec:authorize>
<!-- Header Start -->
<!-- <header class="app-header"> -->
<header class="topbar">
    <nav class="navbar navbar-expand-lg navbar-light">
        <ul class="navbar-nav">
            <li class="nav-item d-block d-xl-none"><a
                    class="nav-link sidebartoggler nav-icon-hover" id="headerCollapse"
                    href="javascript:void(0)"> <i class="ti ti-menu-2"></i>
            </a></li>
        </ul>
<div id="magStack"></div>
        <div class="navbar-collapse justify-content-end px-0" id="navbarNav">
            <ul class="navbar-nav flex-row ms-auto align-items-center justify-content-end">
            	
            	<!-- 종 아이콘 -->
				<jsp:include page="frcsalarmIcon.jsp"></jsp:include>

<!--                 <li>스케쥴(달력) 아이콘 -->
<!--                     <a href=#> -->
<!--                         <i class="ti ti-calendar" style="font-size: 30px; margin: 5px;"></i> -->
<!--                     </a> -->
<!--                 </li> -->

<!--                 <li>사용자 아이콘 -->
<!--                     <a href=#> -->
<!--                         <i class="ti ti-user" style="font-size: 30px; margin: 5px;"></i> -->
<!--                     </a> -->
<!--                 </li> -->
				

                <li class="nav-item dropdown">
                    <a class="nav-link nav-icon-hover" href="javascript:void(0)"
                        id="drop2" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="/resources/bootstrap/src/assets/images/profile/user-1.jpg"
                        alt="" width="35" height="35" class="rounded-circle">
                    </a>
                    <!-- 프로필 눌렀을 때 나오는 화면 -->
                    <div class="dropdown-menu dropdown-menu-end dropdown-menu-animate-up"
                            aria-labelledby="drop2">
                        <div class="message-body">
                            <a href="javascript:void(0)"
                               class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-user fs-6"></i>
                                <p class="mb-0 fs-3">My Profile</p>
                            </a>
                            <a href="javascript:void(0)"
                               class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-mail fs-6"></i>
                                <p class="mb-0 fs-3">My Account</p>
                            </a>
                            <a href="javascript:void(0)"
                               class="d-flex align-items-center gap-2 dropdown-item">
                                <i class="ti ti-list-check fs-6"></i>
                                <p class="mb-0 fs-3">My Task</p>
                            </a>
                            <form action="/frcs/logout" method="post">
                                <button type="submit" class="btn btn-outline-primary mx-3 mt-2 d-block">
                                    Logout
                                </button>
                                <sec:csrfInput/>
                            </form>
                        </div>
                    </div>
                </li>

            </ul>
            <!-- 프로필 오른쪽 가맹점 선택 창 -->
            <div>
                <form id="frm" action="/frcs/changeFrcs" method="post" style="margin: 1px;">
                    <select id="frcsNo" name="frcsNo" class="form-select">
                        <c:forEach var="franchiseVO" items="${ownerVO.franchiseVOList}" varStatus="stat">
                            <option value="${franchiseVO.frcsNo}"
                                    <c:if test="${franchiseVO.frcsNo==sessionScope.crrFrcsNo}">selected</c:if>
                            >${franchiseVO.frcsNm}</option>
                        </c:forEach>
                    </select>
                    <sec:csrfInput/>
                </form>
            </div>
        </div>
    </nav>
    
</header>
<!-- Header End -->
<script type="text/javascript">
$(function () {
    $("#frcsNo").on("change", function () {
        let frcsNo = $(this).val();

        console.log("frcsNo : " + frcsNo);

        $("#frm").submit();
    });
});

var socket = null; // 소켓 전역변수 선언

$(document).ready(function() {

let userId = "${sessionScope.userId}";
console.log("userId: ", userId);

<sec:authorize access="isAuthenticated()">
connectWS();
</sec:authorize>
});

// 웹소켓 연결 함수
function connectWS() {
var ws = new SockJS("/echo"); // 소켓 객체 생성
socket = ws;

console.log("웹소켓: ", socket);

ws.onopen = onOpen;
ws.onmessage = onMessage;
ws.onclose = onClose;
ws.onerror = onError;
}

// 소켓 연결
function onOpen() {
console.log("소켓 연결 (onopen)");
// socket.send("원종찬");
};

// 메시지 수신
function onMessage(evt) {
	console.log("onMessage 함수: ", evt.data);
	var data = JSON.parse(evt.data);
	console.log("data!!!!!!!!!!", data[0].movUrl, "+++++", data[0].alarmConts, ",,,,,,", data[0].alarmRcverId);
	
	let hasClass = $("#bellIcon").hasClass("ti ti-bell");
	console.log("onMessage!!!!!!: ", hasClass);
	
	let str = "";
	let str2 = "";
	let dataLength = data.length;
	$.each(data, function(idx) {
		str += `
		<div
			class="dropdown-menu content-dd dropdown-menu-end dropdown-menu-animate-up "
			aria-labelledby="drop2" data-bs-popper="static">
			<div
				class="d-flex align-items-center justify-content-between py-3 px-7">
				<h5 class="mb-0 fs-5 fw-semibold">알림</h5>
				<span class="badge text-bg-primary rounded-4 px-3 py-1 lh-sm">\${dataLength} new</span>
			</div>
			<div class="message-body simplebar-scrollable-y" data-simplebar="init">
				<div class="simplebar-wrapper" style="margin: 0px;">
					<div class="simplebar-height-auto-observer-wrapper">
						<div class="simplebar-height-auto-observer"></div>
					</div>
					<div class="simplebar-mask">
						<div class="simplebar-offset" style="right: 0px; bottom: 0px;">
							<!-- 알림 들어갈 공간 -->
							<div class="simplebar-content-wrapper" tabindex="0" role="region"
								aria-label="scrollable content"
								style="height: auto; overflow: hidden scroll;">
								<div class="simplebar-content" style="padding: 0px;">
									<a href="#" data-url="\${data[idx].movUrl}" data-id="\${data[idx].alarmNo}"
									   class="py-6 px-7 d-flex align-items-center dropdown-item clickAlarm">
										<span class="me-3"> <img
											src="/resources/bootstrap/src/assets/images/profile/user-1.jpg" alt="user"
											class="rounded-circle" width="48" height="48">
									</span>
										<div class="w-75 d-inline-block v-middle">

											<span class="fs-2 d-block text-body-secondary">
												\${data[idx].alarmConts}
											</span>
										</div>
									</a>
								</div>
							</div>
							<!-- 알림 들어갈 공간 끝 -->
						</div>
					</div>
					<div class="simplebar-placeholder"
						style="width: 360px; height: 432px;"></div>
				</div>
				<div class="simplebar-track simplebar-horizontal"
					style="visibility: hidden;">
					<div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
				</div>
				<div class="simplebar-track simplebar-vertical"
					style="visibility: visible;">
					<div class="simplebar-scrollbar"
						style="height: 300px; display: block; transform: translate3d(0px, 0px, 0px);"></div>
				</div>
			</div>
		</div>`;
		
		if(dataLength > 0) {
			$("#bellIcon").removeClass("ti ti-bell").addClass("ti ti-bell-ringing");
			str2 += `<div class="notification bg-primary rounded-circle"></div>`;
		} else {
			$("#bellIcon").removeClass("ti ti-bell-ringing").addClass("ti ti-bell");
		}
	});
	
	console.log("str!!!!!!!!! ", str);
	$("#frcsAlarmArea").prepend(str);
	$("#drop2").append(str2);

};

// 소켓 종료
function onClose() {
console.log("소켓 종료 (onclose)");
};

// 소켓 에러
function onError() {
console.log("소켓 에러 (onerror)");
};

// 알람을 클릭함과 동시에 알람 체크 Y 로 업데이트 (동적으로 만들어진 녀석을 실행시키려면 $(document) 써줘야함)
$(document).on("click", ".clickAlarm", function() {
	
	let alarmNo = $(this).data("id");
	let movUrl = $(this).data("url");
	console.log("movUrl: ", movUrl);
	console.log("alarmNo: ", alarmNo);
	let data = {
		"alarmNo":alarmNo
	}
	
	$.ajax({
		url:"/alarm/updateAlarmChecked",
		contentType:"application/json;charset=utf-8",
		dataType:"json",
		type:"post",
		data:JSON.stringify(data),
		beforeSend : function(xhr) {
	        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    },
	    success:function(result) {
	    	console.log("result: ", result);
	    	if(result > 0) {
		    	location.href = movUrl; // ajax: success에서 처리해주면됨
	    	}
	    },
	    error:function(err) {
	    	console.log("error: ", err);
	    }
	});
});



</script>