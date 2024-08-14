<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script type="text/javascript">
    function dateList() {
        let cal1 = $("#cal1").val();
        let cal2 = $("#cal2").val();
        var csrfToken = $("meta[name='_csrf']").attr("content");
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");  
        $.ajax({
            url : "dateOrder.ajax",
            type : "post",
            data : {
                "cal1" : cal1,
                "cal2" : cal2,
                "_csrf": csrfToken
            },
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success : function(res) {
                $("#logNameChart").remove();
                $("#logNameChart2").remove();
                $("#canvasDiv").append('<canvas id="logNameChart" style="width: 600px; height: 400px;"></canvas>');
                $("#canvasDiv").append('<canvas id="logNameChart2" style="width: 600px; height: 400px;"></canvas>');
                var jsonObject = res;
                var jData = JSON.parse(jsonObject);

                var labelList = [];
                var valueList = [];
                var colorList = [];
                var cntList = [];

                for (var i = 0; i < jData.length; i++) {
                    var d = jData[i];
                    labelList.push(d.Storename);
                    valueList.push(d.Totprice);
                    colorList.push(colorize());
                    cntList.push(d.Cnt);
                }
                var data = {
                    labels : labelList,
                    datasets : [ {
                        label : '금액',
                        backgroundColor : '#FF7DA8',
                        data : valueList
                    } ]
                };
                var data2 = {
                        labels : labelList,
                        datasets : [ {
                            label : '건수',
                            backgroundColor : '#00C7E2',
                            data : cntList
                        } ]
                    };
                var ctx1 = document.getElementById('logNameChart').getContext('2d');
                var ctx2 = document.getElementById('logNameChart2').getContext('2d');

                var myChart = new Chart(ctx1, {
                    type : 'bar',
                    data : data,
                    options : {
                        title : {
                            display : true,
                            text : '기간 별 매출(가격)'
                        },
                        responsive : true,
                        maintainAspectRatio : false,
                        scales : {
                            yAxes : [ {
                                ticks : {
                                    beginAtZero : true,
                                    callback : function(value, index) {
                                        if (value.toString().length > 8)
                                            return (Math.floor(value / 100000000)).toLocaleString("ko-KR") + "억";
                                        else if (value.toString().length > 4)
                                            return (Math.floor(value / 10000)).toLocaleString("ko-KR") + "만";
                                        else
                                            return value.toLocaleString("ko-KR");
                                    }
                                },
                            } ]
                        },
                    }
                });
                var myChart2 = new Chart(ctx2, {
                    type : 'bar',
                    data : data2,
                    options : {
                        title : {
                            display : true,
                            text : '기간 별 매출(주문건수)'
                        },
                        responsive : true,
                        maintainAspectRatio : false,
                        scales : {
                            yAxes : [ {
                                ticks : {
                                    beginAtZero : true,
                                    callback : function(value, index) {
                                        return value.toLocaleString("ko-KR");
                                    }
                                },
                            } ]
                        },
                    }
                });
            },
            error : function(err) {
                console.log(err);
            }
        })
    }
    function colorize() {
        var r = Math.floor(Math.random() * 200);
        var g = Math.floor(Math.random() * 200);
        var b = Math.floor(Math.random() * 200);
        var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.7)';
        return color;
    }

    $(document).ready(function() {
        $('#cal1').datepicker();
        $('#cal2').datepicker();
        
        // Show initial message
        $('.message').fadeIn('slow').delay(2000).fadeOut('slow');
    });

    $.datepicker.setDefaults({
        dateFormat : 'yy-mm-dd',
        showOtherMonths : true,
        showMonthAfterYear : true,
        changeYear : true,
        changeMonth : true,
        buttonText : "선택",
        yearSuffix : "년",
        monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ],
        monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
        dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
        dayNames : [ '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일' ],
        minDate : "-3Y",
        maxDate : "+3Y"
    });

    $('#cal1').datepicker('setDate', '-1D');
    $('#cal2').datepicker('setDate', 'today');
</script>