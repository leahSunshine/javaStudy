<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>helloword echarts</title>
<script type="text/javascript" src="/resources/echarts/echarts.min.js"></script>
</head>
<body>
<div id="main" style="width:500px ;height:500px;" ></div>
<script type="text/javascript">
var myCharts= echarts.init(document.getElementById("main"));
var data={
		//图形标题
		title:{
			text:"柱形图入门",
			left:'center'
		},
		//工具栏
		toolbox:{
			show:true,
			left:0,
		    bottom:20,
			feature:{
				saveAsImage:{
					show:true
				},
				dataView :{
					show:true
				},
				restore :{
					show:true
				},
				dataZoom :{
					show:true
				},
				magicType: {
			        type: ['line', 'bar']
			    }
			}
		},
		 // 图例
	    legend: {
	        data: ['销量'],
	        right:0,
	        bottom:0,
	        width:100,
	        height:100
	    },
	    // x轴
	    xAxis: {
	        data: ["衬衫", "羊毛衫", "雪纺衫", "裤子", "高跟鞋", "袜子"]
	    },
	    yAxis: {},
	    //折线图数据
	    series: [{
	        name: '销量',
	        type: 'line',
	        data: [15, 20, 16, 30, 45, 61],
	        markPoint :{
	        	data:[{type:'max',name:'最大值',symbol:'pin'},
	        	      {type:'min',name:'最小值',symbol:'diamond'},
	        	      {type:'average',name:'平均值',symbol:'diamond'}
	        	]
	        },
	        markLine :{
	        	data:[{type:'max',value:'最大值',symbol:'pin'},
	        	      {type:'min',value:'最小值',symbol:'diamond'},
	        	      {type:'average',value:'平均值',symbol:'diamond'}
	        	]
	        }
	        
	    },{
	    	//柱形图数据
	    	name: '销量',
	        type: 'bar',
	        data: [5, 20, 16, 3, 34, 48]
	    }],
	    //提示信息
	    tooltip:{
	    	trigger:'axis'
	    }
};
//使用刚指定的配置项和数据显示图表。
myCharts.setOption(data);
</script>
</body>
</html>