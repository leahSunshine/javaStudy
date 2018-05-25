<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>histogram.jsp</title>
<!-- <script src="./resources/d3.min.js" charset="UTF-8" ></script> -->
<!-- <script src="./resources/d3.js" charset="UTF-8" ></script> -->
<script src="/resources/d3.v3.min.js" charset="UTF-8" ></script>
<style type="text/css">
	.mycircle{
		fill:green;
		stroke:black;
		stroke-width:1px;
	}
	.myrect{
		/* fill:green; */
		stroke:red;
		stroke-width:1px;
	}
	.myrecty{
		fill:green;
		stroke:red;
		stroke-width:1px;
	}
	
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
	.mytext {
    fill: white;
    text-anchor: middle;
}
</style>
</head>
<body>
</body>
<script type="text/javascript">
	var arrs=["23","rwer","ewew"];
	var ps=d3.selectAll("p");
	ps.data(arrs).text(function(d,i){
		return d;
	});
	var body=d3.select("body");
	var svg=body.append("svg")
			.attr("width",400)
			.attr("height",400);
	/* svg.append("circle")
		.attr("cx",25)
		.attr("cy",25)
		.attr("r",20)
		.attr("class","mycircle");
	svg.append("rect")
		.attr("x",48)
		.attr("y",100)
		.attr("width",40)
		.attr("height",44)
		.attr("class","myrect"); */
	/*x方向上面的柱形图  */
	/* var dataset=[10,20,30,40,50];
	svg.selectAll(".myrect")
		.data(dataset)
		.enter()
		.append("rect")
		.attr("x",function(d,i){
			return 40 + i * 40;
		})
		.attr("y",function(d){
			return (60-d)*5;
		})
		.attr("width",36)
		.attr("height",function(d){
			return d*5;
		})
		.attr("class","myrect"); */
	/* //线性比例尺
	var dataset1=[1,3,3,4,6];
	var linear = d3.scaleLinear()
					.domain([0,d3.max(dataset1)])
					.range([0,300]);
	console.log(linear(0.9));//0
	console.log(linear(1.0));//12.5
	console.log(linear(2.3));//175
	console.log(linear(3.2));//287.5
	console.log(linear(3.3));//300 */
	/*y方向的柱形图  
	
	svg.selectAll(".myrecty")
		.data(dataset1)
		.enter()
		.append("rect")
		.attr("x",100)
		.attr("y",function(d,i){
			return 20 + i*25;
		})
		.attr("width",function(d,i){
			return linear(d);
		})
		.attr("height",20)
		.attr("class","myrecty");*/
	/* //序数比例尺
	var Ordinal = d3.scaleOrdinal()
					.domain([0,2,3,5,6,7])
					.range(["blue","yellow","red","black","green","orange"]);
	console.log(Ordinal(1));//300
	console.log(Ordinal(8));//0
	console.log(Ordinal(8));//12.5
	console.log(Ordinal(9));//175
	console.log(Ordinal(10));//287.5 */
	
	//定义一个带有坐标轴，矩形，文字的柱形图
	//坐标轴
	//坐标轴是由比例尺、轴、以及承载他们的g构成
	var dataset1=[0,1,3,3,4,6,10];
	//序数比例尺
	var xlinear = d3.scale.ordinal()
					.domain(d3.range(dataset1.length))
					.rangeRoundBands([0,200]);
	//绑定了比例尺的坐标轴
	var xaxis=d3.svg.axis()
				.scale(xlinear)
				.orient("bottom")
				.ticks(5);
	//将group绑定到坐标轴
	svg.append("g")
		.attr("class","axis")
		.attr("transform","translate(50,230)")
		.call(xaxis);
	var ylinear = d3.scale.linear()
					.domain([50,0])
					.range([0,200]);
	var yaxis=d3.svg.axis()
				.scale(ylinear)
				.orient("left")
				.ticks(15,'%');//可以这样添加%使得数据为百分数
	svg.append("g")
		.attr("class","axis")
		.attr("transform","translate(50,30)")
		.call(yaxis);
	//矩形
	var dataSets=[10,15,45,50,10,55,35];
	ylinear.domain([0,50]);
	svg.selectAll(".myrect")
		.data(dataSets)
		.enter()
		.append("rect")
		.attr("x",function(d,i){
			return xlinear(i);
		})
		.attr("width",xlinear.rangeBand()-4)
		.attr("class","myrect")
		.attr("transform","translate(50,0)")
		.attr("fill","steelblue")		//填充颜色不要写在CSS里
		.on("mouseover",function(d,i){
			d3.select(this)
				.attr("fill","yellow");
		})
		.on("mouseout",function(d,i){
			d3.select(this)
				.transition()
		        .duration(500)
				.attr("fill","steelblue");
		})
		.attr("height",function(d){
			return 0;
		})
		.attr("y",function(d){
			return 230-ylinear(ylinear.domain()[0]);
		})
		.transition()
		.duration(2000)
		.delay(function(d,i){
			return 200*i;
		})
		.ease("bounce")
		.attr("y",function(d){
		    return 230-ylinear(d);
		})
		.attr("height",function(d){
			return ylinear(d);
		});
	//文字
	svg.selectAll(".mytext")
		.data(dataSets)
		.enter()
		.append("text")
		.attr("x",function(d,i){
			return xlinear(i);
		})
		.attr("dx",(xlinear.rangeBand()-4)/2)
		.attr("dy",function(){
			return 20;
		})
		.attr("class","mytext")
		.attr("transform","translate(30,0)")
		.text(function(d){
			return d;
		})
		.attr("y",function(d){
			return 230-ylinear(ylinear.domain()[0]);
		})
		.transition()//开始过度
		.duration(2000)//持续时间2秒
		.delay(function(d,i){
			return 200*i;//每一个的延迟时间
		})
		.ease("bounce")//动画效果
		.attr("y",function(d){
			return 230-ylinear(d);
		});
	
	
	
	
	
</script>
</html>