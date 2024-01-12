<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
  table {
    width: 100%;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: right;
  }
  th {
    background-color: #f2f2f2;
    text-align: center;
  }
  .left-align {
    text-align: left;
    padding-left: 15px; /* 왼쪽 패딩 값 */
  }
  .left-align-special {
    text-align: left;
    padding-left: 25px; /* 특정 항목에 대한 왼쪽 패딩 값 */
  }
  
/* 배너 위아래 크기 고정 */
#bgInfoSubtle{
	height : 125px;
	background: linear-gradient(45deg, #d5f3f2, #e0f6fb)!important;
}

/* 배너 안에 글씨 위치 고정 */
#subTitlePosition{
	height: 100%
}
.left{
	padding-left : 15px;
}
</style>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/css/datePicker.css">

<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="bgInfoSubtle">
  <div class="card-body px-4 py-3">
    <div class="row align-items-center" id="subTitlePosition">
      <div class="col-9">
        <h4 class="fw-semibold mb-8">기간별 매출 관리</h4>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/admin/main">Main</a>
            </li>
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/admin/hqSales/main">매출 관리</a>
            </li>
            <li class="breadcrumb-item" aria-current="page">기간별 매출 관리</li>
          </ol>
        </nav>
      </div>
      <div class="col-3">
          <div class="text-center mb-n5">
              <img src="/resources/image/배너(누끼)_매출차트.png" alt=""
                   class="img-fluid" style="width: 50%; margin-top:-25px;">
          </div>
      </div>
    </div>
  </div>
</div>
<div class="container-fluid">
<div>
            <!--  Owl carousel -->
            <h3 class="fw-semibold mt-4 mb-4">본사 매출</h3>
            <!--  Row 1 -->
            <div class="row">
              <div class="col-lg-8 d-flex align-items-strech">
                <div class="card w-100">
                  <div class="card-body">
                    <div class="d-sm-flex d-block align-items-center justify-content-between mb-9">
                      <div class="mb-3 mb-sm-0">
                        <!-- <h5 class="card-title fw-semibold">본사 매출</h5> -->
                      </div>
                    </div>
                    <div class="row align-items-center">
                   	 <div id="wrap">
					   <div id="chart-year" class="mb-4">
					       <!-- 차트 컨테이너 -->
					   </div>
					   <div id="chart-quarter">
					       <!-- 차트 컨테이너 -->
					   </div>
					</div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 d-flex align-items-strech">
                <div class="card w-100">
                  <div class="card-body">
                  <h5 class="card-title fw-semibold">매출 비중</h5>
                    <br>
                    <div id="piechart" class="mb-4"> </div>
                    <div id="piechart2"> </div>
                </div>
              </div>
            </div>
          </div>
          <div class="card">
          <div>
          <h1 class="card-title fw-semibold  mt-2 mb-2 left">상세 내역</h1>
          <div>
			<table id="financial-table">
			  <!-- 테이블 헤더 -->
			  <thead>
			    <tr>
			      <th>항목</th>
			      <!-- 연도 헤더는 여기에 동적으로 추가됩니다 -->
			    </tr>
			  </thead>
			  <!-- 테이블 바디 -->
			  <tbody>
			    <!-- 데이터 로우는 여기에 동적으로 추가됩니다 -->
			  </tbody>
			</table>
          </div>
		</div>
		</div>
		<div class="card">
		    <div id="hiddenTable">
           <h3 class="card-title fw-semibold  mt-2 mb-2 left" id="monthTableTitle"></h3>
			<table id="monthTable">
			  <!-- 테이블 헤더 -->
			  <thead>
			    <tr>
			      <th>항목</th>
			      <!-- 연도 헤더는 여기에 동적으로 추가됩니다 -->
			    </tr>
			  </thead>
			  <!-- 테이블 바디 -->
			  <tbody>
			    <!-- 데이터 로우는 여기에 동적으로 추가됩니다 -->
			  </tbody>
			</table>
          </div>
		</div>
</div>
	
<script type="text/javascript">

var maindata = JSON.parse('${maindata}');
    console.log("data 왔다", maindata);

    function convertTimestampToDate(timestamp) {
        var date = new Date(timestamp);
        return date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0');
    }

    // 배열의 모든 원소에 대해 날짜 변환 수행
    maindata.month.forEach(item => {
        item.MONTH = convertTimestampToDate(item.MONTH);
    });

	//월별 data
    var month = maindata.month
    var monthSales = maindata.monthSales;
    
 // 년도별로 데이터를 그룹화하는 함수
    function groupByYear(dataArray) {
        return dataArray.reduce((acc, currentValue) => {
            // 'MONTH' 필드에서 년도 추출
            let year = currentValue.MONTH.split('-')[0];

            // 해당 년도의 키가 이미 accumulator에 있는지 확인
            if (!acc[year]) {
                acc[year] = []; // 해당 년도의 키가 없으면 새 배열 생성
            }

            acc[year].push(currentValue); // 현재 값을 해당 년도의 배열에 추가
            return acc;
        }, {});
    }

    var monthData = groupByYear(month);
    console.log("monthData -> ",monthData);
    
    //전체 파이차트에 넣을 data
    var bigPieNm=Object.keys(maindata.salesP[0]);
    var bigPieVal=Object.values(maindata.salesP[0]);
    
    console.log("bigPieNm ->",bigPieNm);
    console.log("bigPieVal ->",bigPieVal);
    
    function updateSecondTable(selectedYear) {
    	
        var thead = document.querySelector("#monthTable thead tr");
        var tbody = document.querySelector("#monthTable tbody");
		
        
		var title = selectedYear + "년 월별 상세내역";
		
		$("#monthTableTitle").html(title);
		
        // 테이블 헤더와 바디 초기화
        thead.innerHTML = '';
        tbody.innerHTML = '';
    	createFinancialTable(selectedYear);
		
    	}
    
    
	function createFinancialTable(selectedYear) {
	    // Helper function to format numbers
	    function formatNumber(num) {
	        return num.toLocaleString(undefined, {maximumFractionDigits: 0});
	    }

	    var yearData = monthData[selectedYear];
	    
	    // Calculate financials
	    var calculatedData = yearData.map(data => {
	        var operatingIncome = data.SALES - data.TOTALORDER - data.SALARY;
	        var nonOperatingIncome = operatingIncome * 1.1;
	        var nonOperatingExpenses = operatingIncome * 0.9;
	        var netIncome = operatingIncome + nonOperatingIncome - nonOperatingExpenses;

	        return {
	            'MONTH': data.MONTH,
	            '매출액': formatNumber(data.SALES),
	            '매출원가': formatNumber(data.TOTALORDER),
	            '매출총이익': formatNumber(data.SALES - data.TOTALORDER),
	            '판관비': formatNumber(data.SALARY),
	            '영업이익': formatNumber(operatingIncome),
	            '영업외수익': formatNumber(nonOperatingIncome),
	            '영업외비용': formatNumber(nonOperatingExpenses),
	            '당기순이익': formatNumber(netIncome)
	        };
	    });

	    // Create table headers for months
	    var thead = document.getElementById('monthTable').querySelector('thead tr');
	    thead.innerHTML = `<th>항목</th>`; 
	    calculatedData.forEach(data => {
	        var th = document.createElement('th');
	        th.textContent = data.MONTH;
	        thead.appendChild(th);
	    });

	    // Financial items
	    var items = ['매출액', '매출원가', '매출총이익', '판관비', '영업이익', '영업외수익', '영업외비용', '당기순이익'];

	    // Add rows for each financial metric
	    var tbody = document.getElementById('monthTable').querySelector('tbody');
	    items.forEach((item,index) => {
	        var tr = tbody.insertRow();
	        var td = tr.insertCell();
	        td.textContent = item; // Item name
	        td.classList.add('left-align'); // Apply left alignment style

	        if (index === 1 || index === 2 || index === 3 || index === 5 || index === 6) {
	    	    td.className += ' left-align-special'; // 특정 항목에 대한 왼쪽 패딩 스타일 추가
	    	  }

	        calculatedData.forEach(data => {
	            var td = tr.insertCell();
	            td.textContent = data[item]; // Value for each month
	        });
	    });
	}
    
    //전체 차트에 넣을 data
    var yearData = maindata.yearData;
    
 // 숫자를 천 단위로 구분하여 문자열로 변환하는 함수
    function formatNumber(num) {
      return num.toLocaleString();
    }
    
    var calculatedData = {};

 // 각 연도별로 계산
    yearData.forEach(function(data) {
      var operatingIncome = data.SALES - data.TOTALORDER - data.SALARY;
      var nonOperatingIncome = operatingIncome * 1.1;
      var nonOperatingExpenses = operatingIncome * 0.9;
      var netIncome = operatingIncome + nonOperatingIncome - nonOperatingExpenses;

      // 정수로 반올림하고 천 단위 구분자 추가
      calculatedData[data.YEAR] = {
        '매출액': formatNumber(Math.round(data.SALES)),
        '매출원가': formatNumber(Math.round(data.TOTALORDER)),
        '매출총이익': formatNumber(Math.round(data.SALES - data.TOTALORDER)),
        '판관비': formatNumber(Math.round(data.SALARY)),
        '영업이익': formatNumber(Math.round(operatingIncome)),
        '영업외수익': formatNumber(Math.round(nonOperatingIncome)),
        '영업외비용': formatNumber(Math.round(nonOperatingExpenses)),
        '당기순이익': formatNumber(Math.round(netIncome))
      };
    });

    // 헤더에 연도 추가
    var thead = document.getElementById('financial-table').querySelector('thead tr');
    Object.keys(calculatedData).forEach(function(year) {
      var th = document.createElement('th');
      th.textContent = year;
      thead.appendChild(th);
    });

    // 각 항목별로 값을 가진 행을 추가
    var tbody = document.getElementById('financial-table').querySelector('tbody');
    var items = ['매출액', '매출원가', '매출총이익', '판관비', '영업이익', '영업외수익', '영업외비용', '당기순이익'];

    items.forEach(function(item, index) {
      var tr = tbody.insertRow();
      var td = tr.insertCell();
      td.textContent = item; // 항목 이름
      td.classList.add('left-align'); // 왼쪽 정렬 스타일 적용

      if (index === 1 || index === 2 || index === 3 || index === 5 || index === 6) {
    	    td.className += ' left-align-special'; // 특정 항목에 대한 왼쪽 패딩 스타일 추가
    	  }

      Object.keys(calculatedData).forEach(function(year) {
        var td = tr.insertCell();
        td.textContent = calculatedData[year][item]; // 각 연도의 값
      });
    });
    
    //각각의 key값별로 배열화
    
    //총 매출
    var sales = yearData.map(item => item.SALES);
    // 인건비
    var salaries = yearData.map(item => item.SALARY);
    // 물건 구입금
    var totalOrders = yearData.map(item => item.TOTALORDER);
    var years = yearData.map(item => item.YEAR);
    //비용
    var cost = yearData.map(item => item.TOTALORDER + item.SALARY);
    var costRate = yearData.map(item => parseFloat(((item.SALES - (item.TOTALORDER + item.SALARY)) / item.SALES * 100).toFixed(1)));
	
    console.log("순익률 -> ", costRate);
    console.log("비용 ->",cost);
    
    
    
var data ={};
data.xName='';
var colors = [
    "#008FFB",
    "#00E396",
    "#FEB019",
    "#FF4560",
    "#775DD0",
    "#00D9E9",
    "#FF66C3"
];

var quarterChartEl = document.querySelector("#chart-quarter");
var piechart2El = document.querySelector("#piechart2");
var yearChartEl = document.querySelector("#chart-year");
var hiddenTable = document.querySelector("#hiddenTable");

var options = {
	    series: [{
	        name: '매출',
	        type: 'column',
	        data: sales
	    }, {
	        name: '비용',
	        type: 'column',
	        data: cost
	    }, {
	        name: '손익률',
	        type: 'line',
	        data: costRate
	    }],
	    xaxis: {
	        categories: years,
	    },
	    yaxis: [
            {
          	seriesName: '매출',
	            opposite: false,
              axisTicks: {
                show: false,
              },
              axisBorder: {
                show: false,
                color: '#d50037'
              },
              labels: {
                style: {
                  colors: '#d50037',
                }
              },
              title: {
                text: "매출 및 비용 (단위 : 천원)",
                style: {
                  color: '#d50037',
                }
              },
              tooltip: {
                enabled: true
              }
            },
            {
          	show : false,
              seriesName: '매출',
              opposite: false,
              axisTicks: {
                show: false,
              },
              axisBorder: {
                show: false,
                color: '#d50037'
              },
              labels: {
                style: {
                  colors: '#d50037',
                }
              },
              title: {
                text: "비용합계 (단위 : 천원)",
                style: {
                  color: '#d50037',
                }
              },
            }, 
            {
              seriesName: '손익률',
              opposite: true,
              axisTicks: {
                show: true,
              },
              axisBorder: {
                show: true,
                color: '#152b4f'
              },
              labels: {
                style: {
                  colors: '#152b4f',
                },
              },
              title: {
                text: "손익률 %",
                style: {
                  color: '#152b4f',
                }
              }
            },
          ],
	    title: {
	        text: '본사 매출',
	        align: 'center', // 제목 위치
	        fontSize: '20px', // 제목 사이즈
	    },
	    dataLabels: {
	        enabled: true
	    },  
	    colors:['#d50037', '#0254d3', '#152b4f'],
	    chart: {
	        id: 'barYear',
	        height: 400,
	        width: '100%',
	        events: {
	            dataPointSelection: function (e, chart, opts) {
	            	console.log("e",e);
	            	console.log("chart",chart);
	            	console.log("opts",opts);
	                

	                //클릭한 data의 index 값
	                var selectedIndex = opts.dataPointIndex;
	                //클릭한 data의 x축 이름
	                data.xName = chart.data.w.globals.categoryLabels[selectedIndex];
	                console.log("나오냐",data.xName);
	                
	                chartQuarter.updateOptions({
	                    title: {
	                        text: data.xName + '년 월별 매출'
	                    }
	                });
	                
	                piechart2.updateOptions({
	                    title: {
	                        text: data.xName + '년 매출 비중'
	                    }
	                });
	                updateSecondChart(data.xName); // 수정된 호출
	                updateSecondPie(selectedIndex);
	                
	                if (opts.selectedDataPoints[0].length === 1) {
	                    yearChartEl.classList.add("chart-quarter-activated");
	                    quarterChartEl.style.display = 'block'; // 쿼터 차트 표시
	                    piechart2El.style.display ='block';
	                    hiddenTable.style.display='block';
	                    
	                } else {
	                    yearChartEl.classList.remove("chart-quarter-activated");
	                    quarterChartEl.style.display = 'none'; // 쿼터 차트 숨기기
	                    piechart2El.style.display ='none';
	                    hiddenTable.style.display='none';
	                }
	            }
	        }
	    },
	};

var chart = new ApexCharts(document.querySelector("#chart-year"), options);
chart.render();

console.log("ss",data.xName);
document.addEventListener('DOMContentLoaded', function() {
    
	quarterChartEl = document.querySelector("#chart-quarter");
    quarterChartEl.style.display = 'none';

    piechart2El = document.querySelector("#piechart2");
    piechart2El.style.display = 'none';
    
    var monthTable1 = document.querySelector("#hiddenTable");
    monthTable1.style.display = 'none';
});


chart.addEventListener('dataPointSelection', function (e, chart, opts) {
    var selectedDataPointIndex = opts.dataPointIndex;
    var selectedIndex = opts.dataPointIndex;
    data.xName = chart.data.w.globals.categoryLabels[selectedIndex];
    
    updateSecondChart(data.xName); // 두 번째 차트 업데이트 함수 호출
    updateSecondPie(selectedIndex);
});

var optionsQuarter = {
    series: [{
        data: []
    }],
    xaxis: {
        categories: [],
    },
    title: {
        text: data.xName+' 월별 매출',
        align: 'center', // 제목 위치
        fontSize: '20px', // 제목 사이즈
    },
    dataLabels: {
        enabled: true
    },
    chart: {
        id: 'barQuarter',
        height: 400,
        width: '100%',
    },
};



var chartQuarter = new ApexCharts(document.querySelector("#chart-quarter"), optionsQuarter);
chartQuarter.render();

//2번쨰 파이차트값 넣기
function updateSecondPie(index){
	console.log("index값이다 -> ",index);
	
	var pieArrayData = monthSales[index];
	
	console.log("두번쨰 차트 data 값 -> ", pieArrayData);
	
	var keys = [];
	var values = [];

	// 객체의 각 속성에 대해 반복
	for (var key in pieArrayData) {
	    // 'YEAR' 키는 제외
	    if (key !== 'YEAR') {
	        keys.push(key);
	        values.push(pieArrayData[key]);
	    }
	}
	
	console.log("key값 ", keys)
	piechart2.updateSeries(values);
	piechart2.updateOptions({
		labels: keys,
	})
}

//2번쨰차트 값 꺼내기
function updateSecondChart(selectedYear) {
	
	updateSecondTable(selectedYear);
    var secondChartData = monthData[selectedYear];
    
    if (!secondChartData) {
        console.error("데이터를 찾을 수 없습니다.");
        return;
    }

    var quartersSeries = [
        { name: '매출', type: 'column', data: secondChartData.map(q => q.SALES) },
        { name: '비용', type: 'column', data: secondChartData.map(q => q.TOTALORDER + q.SALARY) },
        { name: '손익률', type: 'line', data: secondChartData.map(q => {
            const 매출 = q.SALES;
            const 비용 = q.TOTALORDER + q.SALARY;
            if (매출 > 0) {
                return parseFloat(((매출 - 비용) / 매출 * 100).toFixed(1));
            } else {
                return 0; // 매출이 0이하인 경우, 손익률을 0으로 처리
            }
        })}
    ];

    chartQuarter.updateSeries(quartersSeries);
    chartQuarter.updateOptions({
        xaxis: {
            categories: secondChartData.map(q => q.MONTH),
        },
        yaxis: [
            {
          	seriesName: '매출',
	            opposite: false,
              axisTicks: {
                show: false,
              },
              axisBorder: {
                show: false,
                color: '#d50037'
              },
              labels: {
                style: {
                  colors: '#d50037',
                }
              },
              title: {
                text: "매출 및 비용 (단위 : 원)",
                style: {
                  color: '#d50037',
                }
              },
              tooltip: {
                enabled: true
              }
            },
            {
          	show : false,
              seriesName: '매출',
              opposite: false,
              axisTicks: {
                show: false,
              },
              axisBorder: {
                show: false,
                color: '#d50037'
              },
              labels: {
                style: {
                  colors: '#d50037',
                }
              },
              title: {
                text: "비용합계 (단위 : 원)",
                style: {
                  color: '#d50037',
                }
              },
            }, 
            {
              seriesName: '손익률',
              opposite: true,
              axisTicks: {
                show: true,
              },
              axisBorder: {
                show: true,
                color: '#152b4f'
              },
              labels: {
                style: {
                  colors: '#152b4f',
                },
              },
              title: {
                text: "손익률 %",
                style: {
                  color: '#152b4f',
                }
              }
            },
          ],
    });
}

    
    
   //파이차트 
    	
    var pieoptions = {
            series: bigPieVal,
            chart: {
            id:'pie1',
            width: 500,
            type: 'pie',
           
          },
          legend: {
              show: true,
              showForSingleSeries: false,
              showForNullSeries: true,
              showForZeroSeries: true,
              position: 'bottom',
              horizontalAlign: 'center', 
              floating: false,
              fontSize: '14px',
            },
          labels: bigPieNm,
        
          };

          var piechart = new ApexCharts(document.querySelector("#piechart"), pieoptions);
          piechart.render();

          var pieoptions2 = {	
            series: [44, 55, 13, 43, 22],
            chart: {
            id:'pie2',
            width: 500,
            type: 'pie',
           
          },
          legend: {
              show: true,
              showForSingleSeries: false,
              showForNullSeries: true,
              showForZeroSeries: true,
              position: 'bottom',
              horizontalAlign: 'center', 
              floating: false,
              fontSize: '14px',
            },
          labels: ['Team A', 'Team B', 'Team C', 'Team D', 'Team E'],
        
          };

          var piechart2 = new ApexCharts(document.querySelector("#piechart2"), pieoptions2);
          piechart2.render();
		
          


          
          
</script>
