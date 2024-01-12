<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 태현아 여기 
창업 경험 유무랑 상가유무 가로로 바꿀거면 바꾸고~~~~~~
버튼이 승인, 점주 생성, 거절이였는데
애매해서 점주 생성, 거절로만 해놨어 주석처리해놨고!!-->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
div#right {
    padding-right: 40px !important; 
}
</style>
<script type="text/javascript">
$(document).on("click","#confirm",function(){
	let value =$(this).data("value");
	let a = ${inquirerVO.inqrNo};
	let data = {
			"inqrStatusYn":value,
			"inqrNo":a
	}
	
	$.ajax({
		url :"/admin/inqr/status",
		method : "post",
		contentType:"application/json;charset:utf-8;",
		data : JSON.stringify(data),
		dataType : "json",
		beforeSend:function(xhr){ 
               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}"); }
              
	}).done((rst) => {
		console.log(rst);
    	alert("승인 처리 되었습니다.")
    	location.href="/admin/inqr/list";
	}).fail((xhr)=>{
		console.log(xhr);

	})
	
})

$(document).on("click","#refuse",function(){
	let value =$(this).data("value");
	let inqrNo = ${inquirerVO.inqrNo};

	let data = {
			"inqrStatusYn":value,
			"inqrNo":inqrNo
	}
	Swal.fire({
        title: '창업 신청 거절',
        text: `거절 하시겠습니까?`,
        icon: 'warning',

        showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
        confirmButtonColor: '#01c0c8', // confrim 버튼 색깔 지정
        cancelButtonColor: '#ff5757', // cancel 버튼 색깔 지정
        confirmButtonText: '확인', // confirm 버튼 텍스트 지정
        cancelButtonText: '취소', // cancel 버튼 텍스트 지정

    }).then(result => {
    	  if (result.isConfirmed) {
              Swal.fire({
              	
              	
                  title: '거절완료',
                  icon: 'success',

                  showCancelButton: false,
                  confirmButtonColor: '#01c0c8', // confrim 버튼 색깔 지정
                  confirmButtonText: '확인' // confirm 버튼 텍스트 지정

              }).then(result => {
				$.ajax({
					url :"/admin/inqr/status",
					method : "post",
					contentType:"application/json;charset:utf-8;",
					data : JSON.stringify(data),
					dataType : "json",
					beforeSend:function(xhr){ 
			               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}"); },
			        success : function(rst){
			        	console.log("거절 완료");
			        }        
				})//ajax끝
				
				$("#form").submit();
		
              })
		}
	})
})
$(document).on("click","#ownerCreate",function(){
		console.log("클릭")
		     Swal.fire({
                title: '창업 상담 승인',
                text: `승인하시겠습니까?`,
                icon: 'warning',

                showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
                confirmButtonColor: '#01c0c8', // confrim 버튼 색깔 지정
                cancelButtonColor: '#ff5757', // cancel 버튼 색깔 지정
                confirmButtonText: '확인', // confirm 버튼 텍스트 지정
                cancelButtonText: '취소', // cancel 버튼 텍스트 지정
                
            }).then(result => {
                if (result.isConfirmed) {

                    	Swal.fire({
                    	
	                        title: '승인완료',
	                        icon: 'success',
	
	                        showCancelButton: false,
	                        confirmButtonColor: '#01c0c8', // confrim 버튼 색깔 지정
	                        confirmButtonText: '확인' // confirm 버튼 텍스트 지정
                        	
                    
                    }).then(result => {
                        if (result.isConfirmed) {
                        	
                        	
                        	let value =$(this).data("value");
                        	let a = ${inquirerVO.inqrNo};
                        	let data = {
                        			"inqrStatusYn":value,
                        			"inqrNo":a
                        	}
                        	
                        	
                        	$.ajax({
                        		url :"/admin/inqr/status",
                        		method : "post",
                        		contentType:"application/json;charset:utf-8;",
                        		data : JSON.stringify(data),
                        		dataType : "json",
                        		beforeSend:function(xhr){ 
                                       xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}"); }
                                      
                        	}).done((rst) => {
	                        		console.log(rst);
	                            	console.log("승인 처리 되었습니다.")
	                            	$("#form").attr("action","/admin/FranChiseOwner/createForm");
	                    			$("#form").attr("method", "post");
	                    			$("#form").submit();
                        	
                        	}).fail((xhr)=>{
                        		console.log(xhr);
								console.log("실패");
                        	})
                          
                        }// if값 끝
                    })// then 끝
                }
            })
})
</script>
<body>

<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4">
  <div class="card-body px-4 py-3">
    <div class="row align-items-center">
      <div class="col-9">
        <h4 class="fw-semibold mb-8">상담자 정보</h4>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/admin/main">Home</a>
            </li>
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/admin/inqr/waitList">상담자 목록</a>
            </li>
            <li class="breadcrumb-item" aria-current="page">상담자 정보</li>
          </ol>
        </nav>
      </div>
      <div class="col-3">
        <div class="text-center mb-n5">
          <img src="../assets/images/breadcrumb/ChatBc.png" alt="" class="img-fluid mb-n4">
        </div>
      </div>
    </div>
  </div>
</div>

<%-- <p>${inquirerVO}</p> --%>
<div class="row" style="display: flex; justify-content: center;">
            <div class="col-12" >
              <!-- ---------------------
                                  start Event Registration
                              ---------------- -->
              <div class="card">
                <form action="/admin/inqr/update" method="post" id="form">
                	<input type="hidden" name="inqrNo" value="${inquirerVO.inqrNo}">
                  <div class="card-body border-top">
                  <h1 class="fw-semibold fs-7 mb-4" style="margin-left: 10px;">상담자 정보</h1>
                    <div class="row m-auto">
                        <div class="col-6 mb-3">
                          <label for="fname3" class="control-label col-form-label"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">이름</font></font></label>
                          <input type="text" class="form-control" id="fname3" placeholder="성명은 여기에" value="${inquirerVO.inqrNm}" name="inqrNm">
                        </div>
                        <div class="col-6">
                          <label for="title2" class="control-label col-form-label"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">연락처</font></font></label>
                          <input type="text" class="form-control" id="title2" placeholder="010-1111-1111" value="${inquirerVO.inqrTel}" name="inqrTel">
                        </div>
                        
                        <div class="col-6 mb-3">
                          <label for="comname1" class="control-label col-form-label"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">신청 일시</font></font></label>
                          <input type="text" class="form-control" id="comname1" placeholder="신청 시간" value="${inquirerVO.inqrReqDt}" name="inqrReqDt"/>
                        </div>
                        <div class="col-6">
                            <label for="email4" class="control-label col-form-label"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">이메일</font></font></label>
                            <input type="email" class="form-control" id="email4" placeholder="여기로 이메일을 보내세요" value="${inquirerVO.inqrEmail}" name="inqrEmail"/>
                        </div>
                        
                        <div class="col-5 mb-3">
                          <label class="control-label col-form-label">창업 희망 지역</label>
                         <select class="form-select" name="inqrRgnlHope" >
						    <c:forEach var="region" items="${regions}">
						       <option value="${region}" <c:if test="${region eq inquirerVO.inqrRgnlHope}">selected</c:if>>${region}</option>
						   </c:forEach>
						</select>
                        </div>
                        
                        <div class="col-1">
                          <label class="control-label col-form-label"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">창업 경험 유무</font></font></label>
                          <div class="form-check">
                            <div class="form-check">
								<input type="radio" class="form-check-input" id="customControlValidation2" name="inqrStrtpXp" value="Y" <c:if test="${inquirerVO.inqrStrtpXp == 'Y'}">checked</c:if>>
                              <label class="form-check-label" for="customControlValidation2"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">유</font></font></label>
                            </div>
                          </div>
                          <div class="form-check">
                            <div class="form-check">
                              <input type="radio" class="form-check-input" id="customControlValidation3" name="inqrStrtpXp" value="N" <c:if test="${inquirerVO.inqrStrtpXp == 'N'}">checked</c:if>>
                              <label class="form-check-label" for="customControlValidation3"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">무</font></font></label>
                            </div>
                          </div>
                         </div>
                        
                        <div class="col-5">
                            <label for="conno2" class="control-label col-form-label"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">상가 주소</font></font></label>
                            <input type="text" class="form-control" id="conno2" placeholder="여기에 연락하지 마세요" value="${inquirerVO.inqrStoreAddr}" name="inqrStoreAddr">
                        </div>
                        <div class="col-1">
                          <label class="control-label col-form-label"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">상가 유무</font></font></label>
                          <div class="form-check">
                            <div class="form-check">
                              <input type="radio" class="form-check-input" id="customControlValidation5" name="inqrStoreYn" value="Y"<c:if test="${inquirerVO.inqrStoreYn == 'Y'}">checked</c:if>>
                              <label class="form-check-label" for="customControlValidation5"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">유</font></font></label>
                            </div>
                          </div>
                          <div class="form-check">
                            <div class="form-check">
                              <input type="radio" class="form-check-input" id="customControlValidation4" name="inqrStoreYn" value="N"<c:if test="${inquirerVO.inqrStoreYn == 'N'}">checked</c:if>>
                              <label class="form-check-label" for="customControlValidation4"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">무</font></font></label>
                            </div>
                          </div>
                         </div>
                         
  	                  <div class="col-6 mb-3">
                          <label class="control-label col-form-label">희망 금액</label>
						<select class="form-select" name="inqrExpctCost">
							    <c:forEach var="cost" items="${cnt}">
							        <c:choose>
							            <c:when test="${cost eq '100000000'}">
							                <option value="100000000" <c:if test="${cost eq inquirerVO.inqrExpctCost}">selected</c:if>>1억</option>
							            </c:when>
							            <c:when test="${cost eq '150000000'}">
							                <option value="150000000" <c:if test="${cost eq inquirerVO.inqrExpctCost}">selected</c:if>>1.5억</option>
							            </c:when>
							            <c:when test="${cost eq '200000000'}">
							                <option value="200000000" <c:if test="${cost eq inquirerVO.inqrExpctCost}">selected</c:if>>2억</option>
							            </c:when>
							            <c:when test="${cost eq '250000000'}">
							                <option value="250000000" <c:if test="${cost eq inquirerVO.inqrExpctCost}">selected</c:if>>2.5억</option>
							            </c:when>
							            <c:when test="${cost eq '300000000'}">
							                <option value="300000000" <c:if test="${cost eq inquirerVO.inqrExpctCost}">selected</c:if>>3억</option>
							            </c:when>
							        </c:choose>
							    </c:forEach>
							</select>
                      </div>

                        <div class="col-12">
                          <label class="control-label col-form-label">비고</label>
                          <textarea class="form-control" id="exampleTextarea1" rows="8" placeholder="Comments Here" name = "inqrRm">${inquirerVO.inqrRm}</textarea>
                        </div>
                    </div>
                  </div>
                  
                  <div class="p-3 border-top" id="right">
                    <div class="d-md-flex align-items-center">
<!--                       <div class="action-form"> -->
<!--                         <div class="text-center"> -->
<!--                           <button type="submit" class="btn btn-info rounded-pill px-4 waves-effect waves-light"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">저장 -->
<!--                           </font></font></button> -->
<!--                           <button type="button" onclick="location.href='/admin/inqr/list'" class="btn btn-dark rounded-pill px-4 waves-effect waves-light"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">취소 -->
<!--                           </font></font></button> -->
<!--                         </div> -->
<!--                       </div> -->
                      <div class="ms-auto">
                      
<!--                         <div class="btn-group"> -->
<!--                           <button type="button" class="btn btn-info dropdown-toggle" data-value="Y"  id="confirm"> -->
<!--                             <i class="ti ti-download fs-4"></i><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">승인 -->
<!--                           </font></font></button> -->
<!--                         </div> -->
<!--                         <div class="btn-group"> -->
<!--                           <input type="submit" value="생성" formaction="/admin/franchiseOwner/createForm"> -->
                          <button class="btn btn-primary" type="button" id="ownerCreate" data-value="Y"  style="margin-right: 10px;">점주 생성</button>
                          <button class="btn btn-danger" type="button" data-value="N" id="refuse">거절</button>
<!--                           <button type="button" class="btn btn-danger dropdown-toggle" data-value="N"  id="refuse"> -->
<!--                             <i class="ti ti-transition-right me-1 fs-4"></i><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">거절 -->
<!--                           </font></font></button> -->
<!--                         </div> -->
                      </div>
                    </div>
                  </div>
                  <sec:csrfInput />
                </form>
              </div>
            </div>
          </div>
</body>
</html>