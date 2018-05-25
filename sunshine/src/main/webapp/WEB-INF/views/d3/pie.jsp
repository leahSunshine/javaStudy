<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pie.jsp</title>
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
//饼状图的关键是：
//布局（也就是将数单个数组转换为具有开始角、结束角等等的数据）
//弧生成器（内半径，外半径）
//group（将布局生成的数据传给group，绑定数据到每一个分组）,如果只添加path者不需要添加group，只需要添加path，如果需要添加文字，则需要group
//再在group中添加path，d为弧生成器生成的数据，还可以添加颜色需要：颜色的序数比例尺
var width = 500;
var height = 500;
var svg = d3.select("body").append("svg")
			.attr("width",500)
			.attr("height",500);
	d3.json("/resources/polyline.json",function(error,jsondata){
		if(error){
			console.log(error);
			alert(error);
		}else{
			// 布局（数据转换）
			var pie=d3.layout.pie();
			var piedata=pie(jsondata.piedata);
			//弧生成器
			var outerRadius = 150; //外半径
			var innerRadius = 0; //内半径，为0则中间没有空白
			var arc = d3.svg.arc()  //弧生成器
			    .innerRadius(innerRadius)   //设置内半径
			    .outerRadius(outerRadius);  //设置外半径
			var arc2 = d3.svg.arc()  //弧生成器
			    .innerRadius(innerRadius)   //设置内半径
			    .outerRadius(outerRadius+20);  //设置外半径
			 //画布上面添加group   
			  var garc=svg.selectAll("g")
					.data(piedata)
					.enter()
					.append("g")
					.attr("transform","translate(250,250)")
					.on("mouseover", function(d) {
				            d3.select(this).select("path")
								            .transition()
								            .duration(1000)
				            				.ease("bounce")
								            .attr("d", function(d) {
								                return arc2(d);
								            })
				        })
				        .on("mouseout", function(d){
				            d3.select(this).select("path")
				            		.transition()
				            		.duration(1000)
				            		.ease("bounce")
				            		.attr("d", function(d){
						                return arc(d);
						            })
				        });
			 //构造一个有20种颜色的序数比例尺。
			var colors=d3.scale.category20();
			 //给分组添加path
			garc.append("path")
				.attr("fill",function(d,i){
					return colors(i);
				})
				.attr("d",function(d){
					return arc(d);
				})
				; 
			garc.append("text")
		    .attr("transform",function(d){
		    	var center=arc.centroid(d);
		        return "translate(" + center[0] * 1.5 + "," + center[1]* 1.5 + ")";
		    })
		    .attr("text-anchor","middle")
		    .text(function(d){
		        return d.data;
		    });
			//连线
			
			
			
			
			//新建连接线
			var linkLine = g.append("g"); // 创建每条连接线
	        var links = [];
	        arcs.forEach(function (d) { // 输出age文字
	            const startPoint = startPointArc.centroid(d);
	            const endPoint = populationLabelArc.centroid(d);
	            links.push({
	                source: [startPoint[0], startPoint[1]],
	                target: [endPoint[0], endPoint[1]]
	            });
	        });

	        linkLine.selectAll()
	        .data(links)
	        .enter()
	        .append("path")
	                .attr("class", "link-line")
	                .style("stroke", "#999")
	                .style("stroke-width", 1)
	                .attr('fill', 'none')
	                .attr("d", d3.linkHorizontal().source(function(d){ return d.source; }).target(function(d){ return d.target; }));        
	 
	        var label = g.append("g");       

	        arcs.forEach(function (d) { // 输出percent文字
	            const c = percentLabelArc.centroid(d);
	            label.append("text")
	                 .attr("class", "age-text")
	                 .attr('fill', '#cddc39')
	                 .attr('font-weight', '700')
	                 .attr('font-size', '14px')
	                 .attr('text-anchor', 'middle')
	                 .attr('x', c[0])
	                 .attr('y', c[1])
	                 .text((d.data.population * 100 / sumData).toFixed(1) + '%');
	        });

	        arcs.forEach(function (d) { // 输出population文字
	            var c = populationLabelArc.centroid(d);
	            label.append("text")
	                 .attr("class", "age-text")
	                 .attr('fill', '#000')
	                 .attr('font-size', '12px')
	                 .attr('text-anchor', function(d){
	                    return c[0] >= 0 ? 'start' : 'end'; 
	                 })
	                 .attr('x', c[0])
	                 .attr('y', c[1])
	                 .text(d.data.age + '岁 : ' + (d.data.population / 10000).toFixed(2) + '万人');
	        });

			
			
			
			
			
			/*
			//其实不需要分组包含path就可以直接在path上面添加胡生成器即可（下面的方法即可），但是，如果要添加文字，则需要分组才能添加上；
			var colors=d3.scale.category20();
			var paths=svg.selectAll("path")
				.data(piedata)
				.enter()
				.append("path")
				.attr("transform","translate(250,250)")
				.attr("fill",function(d,i){
					return colors(i);
				})
				.attr("d",function(d){
					return arc(d);
				}); */
			
		}
		
	});
</script>
</html>