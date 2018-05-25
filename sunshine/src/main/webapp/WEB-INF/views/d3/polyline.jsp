<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>polyline.jsp</title>
<!-- <script src="./resources/d3.min.js" charset="UTF-8" ></script> -->
<!-- <script src="./resources/d3.js" charset="UTF-8" ></script> -->
<script src="/resources/d3.v3.min.js" charset="UTF-8" ></script>
<style>
	.axis path,
	.axis line{
	    fill: none;
	    stroke: black;
	    shape-rendering: crispEdges;
	}
	 
	.axis text {
	    font-family: sans-serif;
	    font-size: 11px;
	}
	.myPath {
		fill:none;
		stroke:green;
		stroke-width:2px;
	}
</style>
</head>
<body>
</body>
<script type="text/javascript">
//折线图的关键是，坐标轴，线段生成器，path（具有svg的d的属性传入线段生成器生成的数据）;
var svg = d3.select("body").append("svg")
			.attr("width",500)
			.attr("height",500);
	d3.json("/resources/polyline.json",function(error,jsondata){
		if(error){
			console.log(error);
			alert(error);
		}else{
			var xMax=d3.max(jsondata.data,function(d){
				return d.x;
			});
			var yMax=d3.max(jsondata.data,function(d){
				return d.y;
			});
			//比例尺
			var xScale=d3.scale.linear()
						.domain([0,xMax])
						.range([0,300]);
			var yScale=d3.scale.linear()
						.domain([yMax,0])
						.range([0,300]);
			
			//坐标轴
			var xAxis=d3.svg.axis()
						.scale(xScale)
						.orient("bottom");
			var yAxis=d3.svg.axis()
						.scale(yScale)
						.orient("left");
			//给坐标轴添加分组元素
			var gxAxis=svg.append("g")
						.attr("class","axis")
						.attr("transform","translate(50,350)")
						.call(xAxis);
			var gyAxis=svg.append("g")
						.attr("class","axis")
						.attr("transform","translate(50,50)")
						.call(yAxis);
			//线段生成器
			var line=d3.svg.line()
						.x(function(d){return xScale(d.x);})
						.y(function(d){return yScale(d.y);})
						.interpolate("linear");//插值器
			//折线图
			svg.append("path")
					.attr("class","myPath")
					.attr("d",line(jsondata.data))
					.attr("transform","translate(50,50)");
			
		}
		
	});
</script>
</html>