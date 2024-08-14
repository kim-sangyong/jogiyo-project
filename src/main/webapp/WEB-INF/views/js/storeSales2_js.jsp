<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">
    function indateSales(){
        let date1=$("#date1").val();
        let date2=$("#date2").val();
        let storeid=$("#storeid").val();
        var csrfToken = $("meta[name='_csrf']").attr("content");
        var csrfHeader = $("meta[name='_csrf_header']").attr("content"); 
        $.ajax({
            url:"indateSales.ajax",
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
            success:function(res){
                $("#logNameChart").remove();
                $("#logNameChart2").remove();
                $("#canvasDiv").append('<canvas id="logNameChart" style="width: 600px; height: 500px;"></canvas>');
                $("#canvasDiv").append('<canvas id="logNameChart2" style="width: 600px; height: 500px;"></canvas>');
                var jsonObject = res;
                var jData = JSON.parse(jsonObject);

                var labelList = [];
                var valueList = [];
                var colorList = [];
                var labelList2 = [];
                var valueList2 = [];

                for (var i = 0; i < jData.length; i++) {
                    var d = jData[i];
                    valueList.push(d.daily_total);
                    labelList.push(d.daily);
                    colorList.push(colorize());
                    labelList2.push(d.month);
                    valueList2.push(d.monthly_total);    
                }

                var data1 = {
                    labels: labelList,
                    datasets: [{
                        data: valueList,
                        label: "일별 판매량",
                        backgroundColor: colorList,
                        borderColor: 'rgba(85,85,85)',
                        fill: false,
                        showLine: true,
                        spanGaps: true
                    }]
                };

                var data2 = {
                    labels: labelList2,
                    datasets: [{
                        data: valueList2,
                        label: "월별 판매량",
                        backgroundColor: colorList,
                        borderColor: 'rgba(85,85,85)',
                        fill: false,
                        showLine: true,
                        spanGaps: true
                    }]
                };

                var ctx1 = document.getElementById('logNameChart').getContext('2d');
                var ctx2 = document.getElementById('logNameChart2').getContext('2d');

                var myChart = new Chart(ctx1, {
                    type: 'line',
                    data: data1,
                    options: {
                        responsive: false,
                        scales: {
                            x: {
                                beginAtZero: true
                            },
                            y: {
                                beginAtZero: true
                            },
                        },
                        elements: {
                            line: {
                                tension: 0.6
                            }
                        }
                    }
                });

                var myChart2 = new Chart(ctx2, {
                    type: 'line',
                    data: data2,
                    options: {
                        responsive: false,
                        scales: {
                            x: {
                                beginAtZero: true
                            },
                            y: {
                                beginAtZero: true
                            },
                        },
                        elements: {
                            line: {
                                tension: 0.6
                            }
                        }
                    }
                });
            },
            error: function(err) {
                console.log(err);
            }       
        });
    }

    function cancelChart() {
        var canvasDiv = document.getElementById('canvasDiv');

        var logNameChart = document.getElementById('logNameChart');
        var logNameChart2 = document.getElementById('logNameChart2');
        if (logNameChart) {
            logNameChart.remove();
        }
        if (logNameChart2) {
            logNameChart2.remove();
        }

        // 새로운 빈 canvas 요소들을 추가
        canvasDiv.innerHTML = '<canvas id="logNameChart" style="width: 600px; height: 500px;"></canvas><canvas id="logNameChart2" style="width: 600px; height: 500px;"></canvas>';
    }

    function colorize() {
        var r = Math.floor(Math.random() * 200);
        var g = Math.floor(Math.random() * 200);
        var b = Math.floor(Math.random() * 200);
        var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
        return color;
    }
    $(document).ready(function() {
        $('#date1').datepicker();
        $('#date2').datepicker();
    });

    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd',
        showOtherMonths: true,
        showMonthAfterYear: true,
        changeYear: true,
        changeMonth: true,
        buttonText: "선택",
        yearSuffix: "년",
        monthNamesShort: [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ],
        monthNames: [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
        dayNamesMin: [ '일', '월', '화', '수', '목', '금', '토' ],
        dayNames: [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],
        minDate: "-3Y",
        maxDate: "+3Y"
    });

    $('#date1').datepicker('setDate', '-1D');
    $('#date2').datepicker('setDate', 'today');
</script>