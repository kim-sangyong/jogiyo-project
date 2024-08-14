<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">
function menuSales(){
    let date1=$("#date1").val();
    let date2=$("#date2").val();
    let storeid=$("#storeid").val();
    var csrfToken = $("meta[name='_csrf']").attr("content");
     var csrfHeader = $("meta[name='_csrf_header']").attr("content");  
    $.ajax({
       url:"menuSales.ajax",
       type:"post",
       data:{
          "date1": date1,
          "date2": date2,
          "storeid": storeid,
          "_csrf": csrfToken
       },   
       beforeSend: function(xhr) {
              // AJAX 요청 헤더에 CSRF 토큰 추가
              xhr.setRequestHeader(csrfHeader, csrfToken);
          },
          success: function(res) {
              $("#logNameChart").remove();
              $("#canvasDiv").append('<canvas id="logNameChart" style="width: 500px; height: 500px;"></canvas>');

              var jData = JSON.parse(res);
              var labelList = [];
              var valueList = [];
              var colorList = [];

              for (var i = 0; i < jData.length; i++) {
                  var d = jData[i];
                  valueList.push(d.menu_totprice);
                  labelList.push(d.menuname);
                  colorList.push(colorize());
              }

              var data = {
                  labels: labelList,
                  datasets: [{
                      data: valueList,
                      label: "메뉴별 판매량",
                      backgroundColor: colorList
                  }]
              };

              var ctx1 = document.getElementById('logNameChart').getContext('2d');
              var myChart = new Chart(ctx1, {
                  type: 'doughnut',
                  data: data,
                  plugins: [ChartDataLabels],
                  options: {
                      plugins: {
                          legend: {
                              onClick: function(e, legendItem, legend) {
                                  var chart = this.chart;
                                  var index = legendItem.index;

                                  // 데이터셋에서 데이터 삭제
                                  chart.data.datasets[0].data.splice(index, 1);
                                  // 라벨에서 항목 삭제
                                  chart.data.labels.splice(index, 1);

                                  // 차트 업데이트
                                  chart.update();
                              }
                          },
                          datalabels: {
                              formatter: (value, ctx) => {
                                  let sum = ctx.dataset.data.reduce((a, b) => a + b, 0);
                                  let percentage = Math.round((value / sum) * 100) + '%';
                                  return percentage;
                              },
                              color: '#fff',
                          }
                      },
                      title: {
                          display: true,
                          text: '메뉴별 판매 추이'
                      },
                      responsive: false,
                  }
              });
          },
       error : function(err) {
          console.log(err);
       }      
    })
 }
  function cancelChart() {
         // 차트를 포함하는 div 요소를 선택
         var canvasDiv = document.getElementById('canvasDiv');

         // 차트 요소 삭제
         var logNameChart = document.getElementById('logNameChart');
         if (logNameChart) {
             logNameChart.remove();
         }

         // 새로운 빈 canvas 요소 추가
         canvasDiv.innerHTML = '<canvas id="logNameChart" style="  width: 500px; display: flex;  box-sizing: border-box;  height: 500px;"></canvas>';
     }
 function colorize() {
    var r = Math.floor(Math.random()*200);
    var g = Math.floor(Math.random()*200);
    var b = Math.floor(Math.random()*200);
    var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
    return color;
 }

   $(document).ready(function() {
	      $('#date1').datepicker();
	      $('#date2').datepicker();
	   });
	   $.datepicker.setDefaults({
	      dateFormat : 'yy-mm-dd', // Input Display Format 변경
	      showOtherMonths : true, // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
	      showMonthAfterYear : true, // 년도 먼저 나오고, 뒤에 월 표시
	      changeYear : true, // 콤보박스에서 년 선택 가능
	      changeMonth : true, // 콤보박스에서 월 선택 가능
	      //,showOn: "both" // button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
	      //,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" // 버튼 이미지 경로       ,buttonImageOnly: true // 기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	      buttonText : "선택", // 버튼에 마우스 갖다 댔을 때 표시되는 텍스트
	      yearSuffix : "년", // 달력의 년도 부분 뒤에 붙는 텍스트
	      monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ], // 달력의 월 부분 텍스트
	      monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ], // 달력의 월 부분 Tooltip 텍스트
	      dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ], // 달력의 요일 부분 텍스트
	      dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ], // 달력의 요일 부분 Tooltip 텍스트
	      minDate : "-3Y", // 최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	      maxDate : "+3Y" // 최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후) 
	   });

	   $('#date1').datepicker('setDate', '-1D');
	   //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

	   $('#date2').datepicker('setDate', 'today');
	   //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
</script>