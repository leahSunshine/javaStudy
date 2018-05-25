<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>spot.jsp</title>
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
<button onclick="updata()">更新</button>
<button onclick="add()">添加</button>
<button onclick="sub()">减少</button>
</body>
<script type="text/javascript">
var svg=d3.select("body").append("svg")
			.attr("width",500)
			.attr("height",500);
var dataset=[];
for(var i=0;i<10;i++){
	dataset.push({x:Math.random()*100,y:Math.random()*100});
}


//比例尺
var xScale=d3.scale.linear()
			 .domain([0,100])
			 .range([0,300]);
//坐标轴
var xAxis=d3.svg.axis()
			.scale(xScale)
			.orient("bottom");
//分组
var gX=svg.append("g")
		.attr("class","axis")
		.attr("transform","translate(50,350)")
		.call(xAxis);
		
//比例尺
var yScale=d3.scale.linear()
			 .domain([100,0])
			 .range([0,300]);
//坐标轴
var yAxis=d3.svg.axis()
			.scale(yScale)
			.orient("left");
//分组
var gY=svg.append("g")
		.attr("class","axis")
		.attr("transform","translate(50,50)")
		.call(yAxis);
//散点图
var points= svg.selectAll(".myCircle")
				.data(dataset)
				.enter()
				.append("circle")
				.attr("class","myCircle")
				.attr("transform","translate(50,50)")
				.attr("r",8)
				.attr("cx", function(d){ return xScale(d.x);})
				.attr("cy" , function(d){ return yScale(d.y);});
function updata(){
	for(var i=0;i<dataset.length;i++){
		dataset[i].x=Math.random()*100;
		dataset[i].y=Math.random()*100;
	}
	updatePoints();
}
function add(){
	dataset.push({x:Math.random()*100,y:Math.random()*100});
	updatePoints();
}
function sub(){
	dataset.pop();
	updatePoints();
}
//添加动态效果
function updatePoints(){
	var updata=svg.selectAll(".myCircle")
					.data(dataset);
	var enter=updata.enter();
	var exit=updata.exit();
	
	updata.transition()
		.duration(1000)
		.ease("bounce")
		.attr("cx", function(d){ return xScale(d.x);})
		.attr("cy" , function(d){ return yScale(d.y);});
	enter.append("circle")
		.attr("class","myCircle")
		.attr("transform","translate(50,50)")
		.attr("cx", function(d){ return xScale(d.x);})
		.attr("cy" , function(d){ return yScale(d.y);})
		.attr("r",0)
		.transition()
		.duration(1000)
		.ease("bounce")
		.attr("r",8);
	
	exit.attr("fill-opacity",1)
		.transition()
		.duration(1000)
		.ease("bounce")
		.attr("fill-opacity",0)
		.remove();
}
</script>
</html>