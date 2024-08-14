<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<html>
<!-- 3da45714ca37800e11f90fbf41f7b969 javascript key -kakao
		카카오 api key
      ad7c778421cbee420c3bfd89c8d7a557 restapi key -kakao -->

<head>
	<meta charset="utf-8"/>
	<title>Kakao 지도 시작하기</title>
</head>
<script>

  </script>
 <body>
 <div align="center">
<div id="map" style="width:350px;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${key}&libraries=services"></script>
<script>
  var mapContainer = document.getElementById('map'), // 지도를 표시할 div
          mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
          };

  // 지도를 생성합니다
  var map = new kakao.maps.Map(mapContainer, mapOption);

  // 주소-좌표 변환 객체를 생성합니다
  var geocoder = new kakao.maps.services.Geocoder();

  var positions = [
    {
      title: '근린공원',
      address: '경기 남양주시 별내면 청학로68번길 40'
    }
  ];

  positions.forEach(function (position) { //추가한 코드
    // 주소로 좌표를 검색합니다
    geocoder.addressSearch(position.address, function(result, status) {

      // 정상적으로 검색이 완료됐으면
      if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
          map: map,
          position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        //변경한 코드
        var infowindow = new kakao.maps.InfoWindow({
          content: '<div style="width:150px;text-align:center;padding:6px 0;">' + position.title + '</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
      }
    });
  });
</script>
</div>
</body>

</div>

 
 
 
 
 
 <%--
 <body>

  <div align="center">


	<div id="map" style="width:500px;height:400px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3da45714ca37800e11f90fbf41f7b969"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.57099975171264, 126.9924242982874),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		
	</script>
	
	
	
	<br>
	
	
	<!-- 이미지 지도를 표시할 div 입니다 -->
<div id="staticMap" style="width:500px;height:400px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${key}"></script>
<script>
// 이미지 지도에 표시할 마커입니다
var marker = {
    position: new kakao.maps.LatLng(37.57099975171264, 126.9924242982874), 
    	//위도 , 경도값 표시하고싶은 지도에 넣기
    text: 'kg아이티뱅크' // text 옵션에 표시할 text 입력
};

var staticMapContainer  = document.getElementById('staticMap'), // 이미지 지도를 표시할 div
    staticMapOption = { 
        center: new kakao.maps.LatLng(37.57099975171264, 126.9924242982874), // 이미지 지도의 중심좌표
        level: 3, // 이미지 지도의 확대 레벨
        marker: marker // 이미지 지도에 표시할 마커
    };

// 이미지 지도를 생성합니다
var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);

</script>
	<br>
	<br>
	<button type="button" id="searchBtn">검색</button>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3da45714ca37800e11f90fbf41f7b969&libraries=services"></script>
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	
	$('#searchBtn').click(function(){
		// 버튼을 click했을때
		
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch($().val(), function(result, status) {
	
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
	
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">장소</div>'
		        });
		        infowindow.open(map, marker);
	
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		});  
	});
	  --%>
	</script>
	</div>
	
 --%></body>
</html>