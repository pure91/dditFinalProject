<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="/resources/css/noticeList.css"/>

<!-- 헤드부분 -->
<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="bgInfoSubtle">
   <div class="card-body px-4 py-3">
      <div class="row align-items-center" id="subTitlePosition">
         <div class="col-9">
            <h4 class="fw-semibold mb-8">공지사항</h4>
            <nav aria-label="breadcrumb">
               <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a
                     class="text-muted text-decoration-none" href="/admin/main">Main</a>
                  </li>
                  <li class="breadcrumb-item">
                       <a class="text-muted text-decoration-none" href="/admin/notice/list">게시판</a>
                     </li>
                  <li class="breadcrumb-item" aria-current="page">공지사항</li>
               </ol>
            </nav>
         </div>
      </div>
   </div>
</div>
<!-- 헤드부분 끝 -->

<!-- 공지사항 추가 모달 -->
<div id="add-contact" class="modal fade in" tabindex="-1"
   aria-labelledby="myModalLabel" aria-hidden="true" style="display: none">
   <div class="modal-dialog modal-dialog-scrollable modal-lg">
      <div class="modal-content">
         <div class="modal-header d-flex align-items-center">
            <h1 class="modal-title" id="myModalLabel">공지사항 추가</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal"
               aria-label="Close"></button>
         </div>
         <div class="modal-body">
            <form class="form-horizontal form-material" id="frm" onsubmit="return copyContent()"
               action="/admin/notice/writeNtc" enctype="multipart/form-data"
               method="post">

               <div class="form-group row">
                  <label for="ntcTitle" class="col-sm-2 col-form-label"><strong>제목</strong></label>
                  <div class="col-sm-10">
                     <input type="text" id="ntcTitle" name="ntcTitle" class="form-control"
                        placeholder="제목을 입력해주세요" required>
                  </div>
                  <br> <label for="ntcWrtr" class="col-sm-2 col-form-label">작성자</label>
                  <div class="col-sm-10">
                     <input type="text" id="ntcWrtr" name="ntcWrtr" class="form-control" value="${adminNm}"
                        readonly>
                  </div>

                  <label for="ntcConts" class="col-sm-2 col-form-label"><strong>내용</strong></label>
                  <div class="col-sm-10">
                  	 <div id="temp"></div>
                     <textarea id="ntcConts" name="ntcConts" class="form-control"
                     	style="overflow: hidden;display:none;"
                        placeholder="내용을 입력해주세요" required></textarea>
                  </div>

                  <br> <label for="ntcWrtr" class="col-sm-2 col-form-label">파일</label>
                  <div class="col-sm-10">
                     <div style="margin-top: 10px;"
                        class="fileupload btn btn-light-primary btn-rounded waves-light bg-primary-subtle text-primary btn-sm">
                        <span><i class="ion-upload m-r-5"></i>업로드</span> <input
                           type="file" class="upload" name="uploadFile" multiple/>
                     </div>
                  </div>
                  <div class="modal-footer">
		            <button type="button" class="btn btn-info waves-effect" id="btnSave"
		               data-bs-dismiss="modal">작성</button>
		            <button type="button" class="btn btn-default waves-effect"
		               id="btnCancel" data-bs-dismiss="modal">취소</button>
		         </div>
               </div>
               <sec:csrfInput />
            </form>
         </div>
         
      </div>
   </div>
</div>
<!-- 모달끝 -->

<!-- 바디부분 -->
<div class="card">
   <div class="card-body">
      <div id="up-table-group" class="row">
         <div class="col-sm-3">
            <form id="frm">
               <div class="input-group">
                  <input type="text" class="form-control"
                     name="keyword" aria-label="" aria-describedby="basic-addon1">
                  <button class="btn bg-info-subtle text-primary font-medium" type="submit">Search</button>
               </div>
            </form>
         </div>
         <div class="col" id="insert-btn-area">
            <button type="button" class="btn btn-primary btn-rounded m-t-10 mb-2"
            data-bs-toggle="modal" data-bs-target="#add-contact">공지사항 추가</button>
         </div>
      </div>
      <table class="table border text-nowrap customize-table mb-0 align-middle">
         <thead class="text-dark fs-4">
            <tr>
               <th>
                  <h6 class="fs-4 fw-semibold mb-0">번호</h6>
               </th>
               <th>
                  <h6 class="fs-4 fw-semibold mb-0">제목</h6>
               </th>
               <th>
                  <h6 class="fs-4 fw-semibold mb-0">작성자</h6>
               </th>
               <th>
                  <h6 class="fs-4 fw-semibold mb-0">작성일자</h6>
               </th>
            </tr>
         </thead>
<%--          <c:choose> --%>
<%--          <c:when test="${fn: length(noticeVOList) gt 0 }"> --%>
         <tbody>
            <c:forEach var="notice" items="${noticeVOList.content}">
               <tr>
                  <td>
                     <div class="d-flex align-items-center">
                        <p>${notice.ntcNo}</p>
                     </div>
                  </td>
                  <td>
                     <div class="d-flex align-items-center">
                        <a href="/admin/notice/detail?ntcNo=${notice.ntcNo}">${notice.ntcTitle}</a>
                     </div>
                  </td>
                  <td>
                     <div class="d-flex align-items-center">
                        ${notice.ntcWrtr}
                     </div>
                  </td>
                  <td>
                     <div class="d-flex align-items-center">
                        <fmt:formatDate value="${notice.ntcWrtDt}" pattern="yyyy.MM.dd" />
                     </div>
                  </td>
               </tr>
            </c:forEach>
<%--          </c:when> --%>
<%--          <c:otherwise> --%>
<!--             <tbody> -->
<!--                <tr> -->
<!--                   <td colspan="5" style="text-align: center;">공지사항이 없습니다</td> -->
<!--                </tr> -->
<!--             </tbody> -->
<%--          </c:otherwise> --%>
<%--          </c:choose> --%>
         </tbody>
      </table>
      <div id="pagingArea">${noticeVOList.getPagingArea()}</div>
   </div>
</div>

<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script type="text/javascript">
ClassicEditor.create( document.querySelector('#temp'),{ckfinder:{uploadUrl:'/image/upload?${_csrf.parameterName}=${_csrf.token}'}})
.then(editor=>{window.editor=editor;})
.catch(err=>{console.error(err.stack);});

//submit 시 잠시 거쳐가는 곳
function copyContent(){
	//textarea에 div 내용값을 넣어줌
	$("#ntcConts").html(window.editor.getData());
	return true;
}

// 공지사항 작성 ajax
$("#btnSave").on("click", function() {
   if (!confirm("작성 하시겠습니까?")) {
      return;
   }
var Toast = Swal.mixin({
	toast : true,
	position : 'top-end',
	showConfirmButton : false, //true면 ok버튼이 뜸
	timer : 1000, // 1초 동안 표시됨
	timerProgressBar : true
	// true하면 타임게이지 나옴
});
Toast.fire({
	icon : 'success', //출력할 아이콘 종류(success, warning, error, info, quesition)
	title : '공지사항이 등록되었습니다.' //출력할 메세지 내용
});
setTimeout(function() {
	location.reload();
}, 800); //0.8초 이후 자동 새로고침

$("#frm").submit();

//    let form = $("#frm")[0];
//    let formData = new FormData(form);
//    let ntcConts = $("#ntcConts").val();
   
//    console.log("ntcConts: ", ntcConts);
//    console.log("formData: ", formData);
//    $.ajax({
//       url:"/admin/notice/writeNtc",
//       data:formData,
//       type:"post",
//       enctype:"multipart/form-data",
//       processData:false, // 필수: FormData를 쿼리 문자열로 변환하지 않음
//       contentType:false, // 필수: Content-Type 헤더를 설정하지 않음
//       beforeSend:function(xhr){
//            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
//         },
//       success:function(result) {
//          console.log(result);
//          if(result > 0) {
//             var Toast = Swal.mixin({
//                toast : true,
//                position : 'top-end',
//                showConfirmButton : false, //true면 ok버튼이 뜸
//                timer : 1000, // 1초 동안 표시됨
//                timerProgressBar : true
//             // true하면 타임게이지 나옴
//             });
//             Toast.fire({
//                icon : 'success', //출력할 아이콘 종류(success, warning, error, info, quesition)
//                title : '공지사항이 등록되었습니다.' //출력할 메세지 내용
//             });
//             setTimeout(function() {
//                location.reload();
//             }, 800); //0.8초 이후 자동 새로고침
//          }
//       },
//       error:function(err) {
//          console.error(err)
//       }
//    })
});

$("#btnCancel").on("click", function() {
   if (!confirm("작성을 취소하시겠습니까?")) {
      location.href = "/admin/notice/list";
   }
});
</script>