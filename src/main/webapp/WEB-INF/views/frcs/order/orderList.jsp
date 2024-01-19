<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
/* 서브타이틀S  */
#subTitleBg {
    background: linear-gradient(45deg, #eae1f4, #e5e3ff)!important;
    height: 125px;
}
#subTitlePosition{
	height: 100%; /* 기존 이미지가 사라지면서 틀어지는 부분 */
}

#subTitleTxt{
	color :#5a6a85bf;
}
/* 서브타이틀E  */
</style>


<!-- 서브타이틀  -->
<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="subTitleBg">
  <div class="card-body px-4 py-3">
    <div class="row align-items-center" id="subTitlePosition">
      <div class="col-9">
        <h4 class="fw-semibold mb-8">발주 목록</h4>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/frcs/main">Main</a>
            </li>
            <li class="breadcrumb-item" aria-current="page" id="subTitleTxt">
				발주관리
            </li>
<!--             <li class="breadcrumb-item" aria-current="page"> -->
<!--                <a class="text-muted text-decoration-none" href="/frcs/publicdues/main" id="subTitleTxt">매입/매출 분석</a> -->
<!--             </li> -->
          </ol>
        </nav>
      </div>
      <div class="col-3">
        <div class="text-center mb-n5">
<!--           <img src="../../../resources/bootstrap/src/assets/images/breadcrumb/ChatBc.png" alt="" class="img-fluid mb-n4"> -->
        </div>
      </div>
    </div>
  </div>
</div>

<div class="card overflow-hidden invoice-application">
    <div class="d-flex">
        <div class="w-25 d-none d-lg-block border-end user-chat-box">
            <div class="p-3 border-bottom fs-6" style="text-align: center; font-weight: bolder;">
                발주 신청서 목록
            </div>
            <div class="app-invoice">
                <ul class="overflow-auto invoice-users simplebar-scrollable-y" style="height: /*calc(100vh - 400px)*/ 100vh;" data-simplebar="init">
                    <div class="simplebar-wrapper" style="margin: 0px;">
                        <div class="simplebar-height-auto-observer-wrapper">
                            <div class="simplebar-height-auto-observer"></div>
                        </div>
                        <div class="simplebar-mask">
                            <div class="simplebar-offset" style="right: 0px; bottom: 0px;">
                                <div class="simplebar-content-wrapper" tabindex="0" role="region"
                                     aria-label="scrollable content" style="height: 100%; overflow: hidden scroll;">
                                    <%-- 발주 신청서 목록 시작 --%>
                                    <div class="simplebar-content" style="padding: 0px;">

                                        <c:forEach var="frcsOrderVO" items="${frcsOrderVOList}" varStatus="stat">
                                            <li>
                                                <a href="javascript:displayFrcsDetailOrderInvoice(${frcsOrderVO.frcsOrderNo}, ${frcsOrderVO.frcsNo})"
                                                   class="p-3 bg-hover-light-black border-bottom d-flex align-items-start invoice-user listing-user>"
                                                   id="${frcsOrderVO.frcsOrderNo}" data-invoice-id="${frcsOrderVO.frcsOrderNo}">
                                                    <div class="btn round rounded-circle d-flex align-items-center justify-content-center mx-3"
                                                         style="z-index: 99">
                                                        <c:choose>
                                                            <c:when test="${frcsOrderVO.frcsOrderTypeCd eq 'FODST01'}">
                                                            <span class="mb-1 badge rounded-pill font-medium bg-warning-subtle text-secondary"
                                                                  style="z-index: 1;">발주 대기</span>
                                                            </c:when>
                                                            <c:when test="${frcsOrderVO.frcsOrderTypeCd eq 'FODST02'}">
                                                            <span class="mb-1 badge rounded-pill text-bg-primary"
                                                                  style="z-index: 1;">승인</span>
                                                            </c:when>
                                                            <c:when test="${frcsOrderVO.frcsOrderTypeCd eq 'FODST03'}">
                                                        <span class="mb-1 badge rounded-pill text-bg-secondary"
                                                              style="z-index: 1;">반려</span>
                                                            </c:when>
                                                        </c:choose>
                                                    </div>
                                                    <div class="ms-3 d-inline-block w-75">
                                                        <h5 class="my-1 invoice-customer">
                                                            No. ${frcsOrderVO.frcsOrderNo}</h5>
                                                            <%--<span class="fs-3 invoice-id text-truncate text-body-color d-block w-85">${hqOrderVO.hqOrderDt}</span>--%>
                                                        <p class="mb-0 fs-3 text-muted"><fmt:formatDate
                                                                value="${frcsOrderVO.frcsOrderDt}" dateStyle="medium"/></p>
                                                    </div>
                                                </a>
                                            </li>
                                        </c:forEach>

                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="simplebar-placeholder" style="width: 278px; height: 459px;"></div>
                    </div>
                    <div class="simplebar-track simplebar-horizontal" style="visibility: hidden;">
                        <div class="simplebar-scrollbar" style="width: 0px; display: none;"></div>
                    </div>
                    <div class="simplebar-track simplebar-vertical" style="visibility: hidden;">
                        <div class="simplebar-scrollbar" style="height: 300px; display: none;"></div>
                    </div>
                </ul>
            </div>
        </div>
        <div class="w-75 w-xs-100 chat-container">
            <div class="invoice-inner-part h-100">
                <div class="invoiceing-box">
                    <div class="invoice-header d-flex align-items-center border-bottom p-3">
                        <div class="fs-6 text-uppercase">발주 신청서</div>
                    </div>
                    <div id="insertDisplayFrcsDetailOrder">

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="/resources/js/hqOrderInvoice.js"></script>

<script>
    function displayFrcsDetailOrderInvoice(frcsOrderNo, frcsNo) {
        console.log("frcsOrderNo : ", frcsOrderNo);
        console.log("frcsNo : ", frcsNo);

        let data = {
            "frcsOrderNo": parseInt(frcsOrderNo)
            , "frcsNo": parseInt(frcsNo)
        }
        console.log(data)

        $.ajax({
            url: "/frcs/order/displayFrcsOrderInvoice",
            type: "post",
            dataType: "json",
            data: JSON.stringify(data),
            contentType: "application/json;charset=utf-8",
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (result) {
                console.log("완료??");
                console.log("result : " + result.frcsOrderVO.frcsOrderNo);

                $("#insertDisplayFrcsDetailOrder *").remove();

                const token = $("meta[name='_csrf']").attr("content");

                let str = `<div>
                           <form id="submitForm">
                                <input type="hidden" name="frcsOrderNo" value="\${result.frcsOrderVO.frcsOrderNo}">
                                <input type="hidden" name="_csrf" value="\${token}">
                            </form>`;

                let frcsOrderTotalAmt = result.frcsOrderVO.frcsOrderOrderAmt;

                let frcsOrderDt = new Date(result.frcsOrderVO.frcsOrderDt);
                const year = frcsOrderDt.toLocaleDateString('en-US', {
                    year: 'numeric',
                });
                const month = frcsOrderDt.toLocaleDateString('en-US', {
                    month: '2-digit',
                });
                const day = frcsOrderDt.toLocaleDateString('en-US', {
                    day: '2-digit',
                });
                frcsOrderDt = `\${year}. \${month}. \${day}`;
                console.log(frcsOrderDt);

                str += `<div class="p-4" id="custom-invoice">
                                <div class="invoice-123 printableArea" style="display: block;">
                                    <div class="row pt-3">
                                        <div class="col-md-12">
                                            <div class="">
                                            <address>
                                                <h6>&nbsp;From,</h6>
                                                <h6 class="fw-bold">\${result.franchiseVO.frcsNm}</h6>
                                                <p class="ms-1">
                                                    \${result.franchiseVO.frcsAddr}, <br>
                                                    \${result.franchiseVO.frcsDtlAddr},&nbsp;\${result.franchiseVO.frcsPostNo}
                                                </p>
                                                <p class="mt-4 mb-1">
                                                    <span>발주 날짜 :</span>
                                                    <i class="ti ti-calendar"></i>
                                                    \${frcsOrderDt}
                                                </p>
                                            </address>
                                            </div>
                                            <div class="text-end">
                                            <address>
                                                <h6>To,</h6>
                                                <h6 class="fw-bold invoice-customer">ONESOMEPLACE</h6>
                                                <p class="ms-1">종찬오빠 집 주소
                                                    <br>아는 사람 계실까요?
                                                    <br>우편번호도 필요해여 - 00000
                                                </p>
                                            </address>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <div class="table-responsive mt-5" style="clear: both">
                                            <table class="table table-hover">
                                                <thead>
                                                    <!-- start row -->
                                                    <tr>
                                                        <th class="text-center">번호</th>
                                                        <th class="text-center">제품명</th>
                                                        <th class="text-center">카테고리</th>
                                                        <th class="text-center">주문 수량</th>
                                                        <th class="text-center">개당 가격</th>
                                                        <th class="text-center">주문 가격</th>
                                                    </tr>
                                                    <!-- end row -->
                                                </thead>
                                                <tbody>`;
                result.frcsOrderVO.frcsOrderDetailVOList.forEach(function (frcsOrderDetailVO, index){
                    str += `<!-- start row -->
                                                    <tr>
                                                         <td class="text-center">\${index+1}</td>
                                                        <td class="text-center">\${frcsOrderDetailVO.prdctNm}</td>
                                                        <td class="text-center prdctCategory">\${frcsOrderDetailVO.prdctClsfCd}</td>
                                                        <td class="text-end replaceComma">\${frcsOrderDetailVO.frcsOrderQy}</td>
                                                        <td class="text-end replaceComma">\${frcsOrderDetailVO.prdctRcvnAmt}</td>
                                                        <td class="text-end replaceComma">\${frcsOrderDetailVO.frcsOrderCost}</td>
                                                     </tr>
                                                    <!-- end row -->`;
                });
                str += `</tbody>
                                            </table>
                                        </div>
                                    </div></div>
                                        <div class="pull-right mt-2 text-end">
                                            <h3><b>Total :</b> <span class="replaceComma">\${result.frcsOrderVO.frcsOrderOrderAmt}</span></h3>
                                        </div>
                                        <div class="clearfix"></div><hr>`;

                if(result.frcsOrderVO.frcsOrderTypeCd === 'FODST01'){
                    str+=`<div class="text-end mt-2">
                                            <button class="btn btn-secondary mx-1" type="button" onclick="frcsOrderCancel()">
                                                <span><i class="ti ti-circle-x fs-5 me-1"></i>
                                                    발주 취소</span>
                                            </button>
                                        </div>
                                    </div> </div></div>`;
                } else {
                    str += `<div class="text-end mt-2">
                                            <button class="btn my-2 mx-1 waves-effect waves-light btn-light print-all-page" type="button">
                                                <span><i class="ti ti-printer fs-5 me-1"></i>
                                                    PDF 출력</span>
                                            </button>
                                        </div>`;
                }

                $("#insertDisplayFrcsDetailOrder").html(str);

                const cnt = document.querySelectorAll(".replaceComma").length;
                // console.log("cnt===", cnt)

                for (let i=0; i<cnt; i++){
                    let nonComma = document.querySelectorAll(".replaceComma").item(i).innerText;
                    // console.log("nonComma======= : ", nonComma);
                    let comma = nonComma.toString().replace(/\B(?=(\d{3})+(?!\d))/g,',');
                    // console.log("comma========", comma)

                    document.querySelectorAll(".replaceComma").item(i).innerText = comma;

                }
            }
        });
    }


    //발주 취소 버튼
    function frcsOrderCancel() {
        let form = document.getElementById("submitForm");

        Swal.fire({
            title: '발주 취소',
            text: '발주 신청을 취소하시겠습니까?',
            icon: 'question',

            showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
            confirmButtonColor: '#763ebd', // confrim 버튼 색깔 지정
            cancelButtonColor: '#95cfd5', // cancel 버튼 색깔 지정
            confirmButtonText: '확인', // confirm 버튼 텍스트 지정
            cancelButtonText: '취소', // cancel 버튼 텍스트 지정

        }).then(result => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: '취소 완료',
                    icon: 'success',

                    showCancelButton: false,
                    confirmButtonColor: '#763ebd', // confrim 버튼 색깔 지정
                    confirmButtonText: '확인' // confirm 버튼 텍스트 지정

                }).then(result => {
                    if (result.isConfirmed) {
                        form.setAttribute('action', "/frcs/order/frcsOrderCancel");
                        form.setAttribute('method', "post");
                        form.submit();
                    }
                })
            }
        })
    }




</script>