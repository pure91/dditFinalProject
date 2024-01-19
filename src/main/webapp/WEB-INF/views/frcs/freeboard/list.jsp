<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="/resources/bootstrap/src/assets/libs/prismjs/themes/prism-okaidia.min.css">


<%-- <p>${freeBoardVOList}</p> --%>
<style>
.bg-info-subtle {
    background: linear-gradient(45deg, #eae1f4, #e5e3ff)!important;
}
/* --------모달 부분--------- */
.modal {
	    --bs-modal-width: 800px;
}
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

.ck-editor__editable { height: 400px; }
.ck-content { font-size: 12px; }
/* 서브타이틀E  */
</style>

<!-- 서브타이틀  -->
<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="subTitleBg">
  <div class="card-body px-4 py-3">
    <div class="row align-items-center" id="subTitlePosition">
      <div class="col-9">
        <h4 class="fw-semibold mb-8">자유 게시판</h4>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/frcs/main">Main</a>
            </li>
            <li class="breadcrumb-item" aria-current="page">
            	<a class="text-muted text-decoration-none" href="/frcs/freeboard/list">게시판</a>
            </li>
<!--             <li class="breadcrumb-item" aria-current="page"> -->
<!--                <a class="text-muted text-decoration-none" href="/frcs/publicdues/main">공과금 등록</a> -->
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
          <div class="product-list">
            <div class="card">
              <div class="card-body p-3">
				<div class="d-flex justify-content-between align-items-center mb-9">
					<form class="position-relative">
						<input type="text" class="form-control search-chat py-2 ps-5" 
							id="text-srh" placeholder="Search Product">
						<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
					</form>
						<button type="button" id="btnAdd"
							class="btn btn-primary btn-rounded mb-1 createModal"
							data-bs-toggle="modal">
							<i class="ti ti-plus" style="margin-right: 5px;"></i> 글쓰기
						</button>
				</div>
					<div class="table-responsive border rounded">
                  <table class="table align-middle text-nowrap mb-0">
                    <thead>
                      <tr>
                        <th scope="col">번호</th>
                        <th scope="col">제목</th>
                        <th scope="col">작성일</th>
                        <th scope="col">작성자</th>
                        <th scope="col">조회수</th>
                      </tr>
                    </thead>
                    
                    <tbody>
                    <c:forEach var="freeBoardVO" items="${freeBoardVOList}" varStatus="status">    
                      <tr>
                        <td>
                        	<p class="mb-0">${freeBoardVO.freeBoardNo}</p>
                        </td>
                        <td>
                        	<p class="mb-0"><a href="/frcs/freeboard/detail?freeBoardNo=${freeBoardVO.freeBoardNo}">${freeBoardVO.freeBoardTitle}</a></p>
                        </td>
                        <td>
                        	<p class="mb-0"><fmt:formatDate value="${freeBoardVO.freeBoardWrtDt}" pattern="yyyy. MM. dd" /></p>
                        </td>
                        <td>
                        	<p class="mb-0">${freeBoardVO.frcsOwnrNm}</p>
                        </td>
                        <td>
                          <h6 class="mb-0 fs-4">${freeBoardVO.freeBoardView}</h6>
                        </td>
                      </tr>
                      </c:forEach>

                    </tbody>
                  </table>
                  <!-- 페이지네이션 -->
                  <div class="d-flex align-items-center justify-content-end py-1">
                    <p class="mb-0 fs-2">Rows per page:</p>
                    <select class="form-select w-auto ms-0 ms-sm-2 me-8 me-sm-4 py-1 pe-7 ps-2 border-0" aria-label="Default select example">
                      <option selected="">5</option>
                      <option value="1">10</option>
                      <option value="2">25</option>
                    </select>
                    <p class="mb-0 fs-2">1–5 of 12</p>
                    <nav aria-label="...">
                      <ul class="pagination justify-content-center mb-0 ms-8 ms-sm-9">
                        <li class="page-item p-1">
                          <a class="page-link border-0 rounded-circle text-dark fs-6 round-32 d-flex align-items-center justify-content-center" href="#"><i class="ti ti-chevron-left"></i></a>
                        </li>
                        <li class="page-item p-1">
                          <a class="page-link border-0 rounded-circle text-dark fs-6 round-32 d-flex align-items-center justify-content-center" href="#"><i class="ti ti-chevron-right"></i></a>
                        </li>
                      </ul>
                    </nav>
                  </div>
                </div>

              </div>
            </div>
          </div>


<!-- 글쓰기 모달 시작 -->
<div class="modal fade" id="create-modal" tabindex="-1"
	aria-labelledby="addProduct" style="display: none;" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header d-flex align-items-center"
				style="padding-bottom: 0px;">
				<h3 class="modal-title">게시글 등록</h3>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body px-4">
				<form action="/frcs/freeboard/create" method="post" id="frm" enctype="multipart/form-data" onsubmit="return copyContent()">
					<div class="card-body border-top" id="addEdu">
						<div class="row">
							<div class="col-12">
								<div class="mb-3">
									<label for="ojtTitle" class="control-label col-form-label">제목</label>
									<input type="text" class="form-control" id="ojtTitle" name="freeBoardTitle" required> 
									<label id="validationCheckArea"></label>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="mb-3"
									style="display: grid; grid-template-rows: auto auto;">
									<label for=freeBoardConts class="control-label col-form-label">내용</label>
									<div id="temp"></div>
									<textarea rows="15" cols="50" id="freeBoardConts" name="freeBoardConts"
										style="overflow: hidden;display:none;"></textarea>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12">
								<div class="custom-file">
									<input type="file" class="form-control" id="upload"
										name="uploadFile" multiple>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn bg-warning-subtle font-medium"
							data-bs-dismiss="modal" id="btnCancel">취소</button>
						<button type="submit" class="btn btn-primary" id="btnaddForm">등록</button>
					</div>
					<sec:csrfInput />
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 글쓰기 모달 끝 -->

<script src="/resources/bootstrap/src/assets/libs/prismjs/prism.js"></script>
<script src="/resources/bootstrap/src/assets/js/widget/ui-card-init.js"></script>
<script type="text/javascript" src="/resources/ckeditor5/ckeditor.js"></script>
<script type="text/javascript">
ClassicEditor.create( document.querySelector('#temp'),{ckfinder:{uploadUrl:'/image/upload?${_csrf.parameterName}=${_csrf.token}'}})
.then(editor=>{window.editor=editor;})
.catch(err=>{console.error(err.stack);});


//submit 시 잠시 거쳐가는 곳
function copyContent(){
	//textarea에 div 내용값을 넣어줌
	$("#freeBoardConts").html(window.editor.getData());
	return true;
}

// 모달 닫기 함수
function closeModal() {
    $("#create-modal").modal("hide");
}

$(".createModal").on("click", function() {
	
	// input 값 지우기
	$("#addEdu").find('input[type=text]').each(function () {
        $(this).val('');
    });
    $("#addEdu").find('input[type=number]').each(function () {
        $(this).val('');
    });
    $("#addEdu").find('textarea[name=ojtDesc]').each(function () {
        $(this).val('');
    });
    $("#addEdu").find('input[type=date]').each(function () {
        $(this).val('');
    });
    $("#frm").find('select[class=form-select]').each(function () {
        $(this).val('');
    });
	 $("#create-modal").modal("show");
});

</script>
