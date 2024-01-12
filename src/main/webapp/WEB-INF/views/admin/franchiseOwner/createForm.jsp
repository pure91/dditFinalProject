<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
/* 배너 위아래 크기 고정 */
#bgInfoSubtle{
	height : 125px;
	background: linear-gradient(45deg, #d5f3f2, #e0f6fb)!important;
}

/* 배너 안에 글씨 위치 고정 */
#subTitlePosition{
	height: 100%
}
</style>

<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="bgInfoSubtle">
	<div class="card-body px-4 py-3">
		<div class="row align-items-center" id="subTitlePosition">
			<div class="col-9">
				<h4 class="fw-semibold mb-8">가맹점주 생성</h4>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<a class="text-muted text-decoration-none" href="/admin/main">Main</a>
						</li>
						<li class="breadcrumb-item">
			              <a class="text-muted text-decoration-none" href="admin/inqr/waitList">창업 상담</a>
			            </li>
						<li class="breadcrumb-item">
			              <a class="text-muted text-decoration-none" href="admin/inqr/waitList">상담 대기 목록</a>
			            </li>
						<li class="breadcrumb-item">
			              <a class="text-muted text-decoration-none" href="/admin/frcs/list">상세 페이지</a>
			            </li>
						<li class="breadcrumb-item" aria-current="page">가맹점주 생성 </li>
					</ol>
				</nav>
			</div>
			 <div class="col-3">
		          <div class="text-center mb-n5">
		              <img src="/resources/image/배너(누끼)_가맹점.png" alt=""
		                   class="img-fluid mb-n1" style="width: 50%; margin-top: -40px;">
		          </div>
		      </div>
		</div>
	</div>
</div>

<div class="row">
            <div class="col-lg-12"  style="display: flex; justify-content: center;">
              <!-- ---------------------
                                                  start Person Info
                                              ---------------- -->
              <div class="card col-md-12">
                <div class="card-header text-bg-primary">
                  <h4 class="mb-0 text-white">가맹점주 생성</h4>
                  
                </div>
                <form action="/admin/frcs/createForm" method="post" id="frm">
                  <div>
                    <div class="card-body" >
                      <h4>${inquirerVO.inqrNm} 님</h4>
                      <br>
                  	   <input type="hidden" id="frcsOwnrNm" name="frcsOwnrNm" value="${inquirerVO.inqrNm}" />
                      <div class="row ">
                        <div class="col-md-6">
                          <div class="mb-4">
                            <label class="form-label">이메일</label>
                            <input type="text" id="frcsOwnrEmail" name="frcsOwnrEmail" class="form-control" placeholder="이메일" value="${inquirerVO.inqrEmail}" readonly>
                            <small class="form-control-feedback">
                            </small>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="mb-4">
                            <label class="control-label">연락처</label>
                            <input type="text" class="form-control" id="frcsOwnrTel" name="frcsOwnrTel" placeholder="연락처" value="${inquirerVO.inqrTel}" readonly>
                            <small class="form-control-feedback">
                            </small>
                          </div>
                        </div>
                      </div>
                      <div class="row">
                       <div class="col-md-6">
                          <div class="mb-4">
                           <label for="frcsOwnrZip" class="form-label">우편번호</label>
                            <div class="input-group">
                            <input type="text" class="form-control" id="frcsOwnrZip" name="frcsOwnrZip" placeholder="우편번호를 입력하세요"
                                   readonly required>
                            <button type="button" class="btn btn-secondary" id="findZipcodeBtn"
                                    onclick="openDaumPostcode()">우편번호 찾기
                            </button>
                       		 </div>
                          </div>
                      </div>
                        <div class="col-md-6">
                          <div class="mb-4">
                           <label for="frcsOwnrAddr" class="form-label">기본주소</label>
                            <input type="text" class="form-control" id="frcsOwnrAddr" name="frcsOwnrAddr"
                                   placeholder="기본주소를 입력하세요" readonly required>
                          </div>
                        </div>
                      </div>
                      <div class="row">
                        <div class="col-md-6">
                          <div class="mb-4">
                           <label for="frcsOwnrDtlAddr" class="form-label">상세주소</label>
                            <input type="text" class="form-control" id="frcsOwnrDtlAddr" name="frcsOwnrDtlAddr"
                                   placeholder="상세주소를 입력하세요" required>
                          </div>
                        </div>
                        <div class="col-md-6">
                          <div class="mb-4">
                            <label for="ownerAddr3" class="form-label">참고 항목</label>
                            <input type="text" class="form-control" id="ownerAddr3">
                          </div>
                        </div>
                       </div>
                        <!--/span-->
                      </div>
                      <div class="form-actions" >
                      <div class="card-body border-top" id="submitDiv" style="display: flex;align-items: flex-start;justify-content: flex-end;">
                        <button type="button" class="btn btn-success rounded-pill px-4" id="submitBtn">
                          <div class="d-flex align-items-center" >
                            <i class="ti ti-device-floppy me-1 fs-4"></i>
                            저장
                          </div>
                        </button>
                        <button type="button" class="btn btn-danger rounded-pill px-4 ms-2 text-white" onclick="history.back()">
                          취소
                        </button>
                      </div>
                    </div>
                  </div>
                  <sec:csrfInput />
                </form>
              </div>
 </div>
 </div>


<!-- Daum 우편번호 서비스 스크립트 추가 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>

$("#submitBtn").on("click", () => {
	Swal.fire({
        title: '가맹점주 생성',
        text: `가맹점주를 생성하시겠습니까?`,
        icon: 'warning',

        showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
        confirmButtonColor: '#01c0c8', // confrim 버튼 색깔 지정
        cancelButtonColor: '#ff5757', // cancel 버튼 색깔 지정
        confirmButtonText: '확인', // confirm 버튼 텍스트 지정
        cancelButtonText: '취소', // cancel 버튼 텍스트 지정
        
    }).then(result => {
        if (result.isConfirmed) {

        	
            	Swal.fire({
            	
          		
            		
                    title: '생성완료',
                    icon: 'success',

                    showCancelButton: false,
                    confirmButtonColor: '#01c0c8', // confrim 버튼 색깔 지정
                    confirmButtonText: '확인' // confirm 버튼 텍스트 지정
                	
            
            }).then(result => {
                if (result.isConfirmed) {
					
                
                	 $("#frm").submit();
                	 
              	   $("#submitDiv").html(
          			        `
          			    <button class="btn btn-primary" type="submit" disabled>
          			        <span class="spinner-border spinner-border-sm" aria-hidden="true"></span>
          			        <span role="status">Loading...</span>
          			    </button>
          			    `
               	   )
                    
                }// if값 끝
            })// then 끝
        }
    }) 
 
});
    // 우편번호 찾기 팝업 호출 함수
    function openDaumPostcode() {
        new daum.Postcode({
            oncomplete: function (data) {
            	var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                	document.getElementById('ownerAddr3').value = extraAddr;
                
                } else {
                    document.getElementById("ownerAddr3").value = '';
                }
                // 선택한 주소를 폼에 반영
                document.getElementById('frcsOwnrZip').value = data.zonecode;
                document.getElementById('frcsOwnrAddr').value = data.address;
                document.getElementById('frcsOwnrDtlAddr').focus(); // 상세주소로 포커스 이동
            }
        }).open();
    }
</script>
