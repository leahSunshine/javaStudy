<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>helloword echarts</title>
<script type="text/javascript" src="./echarts.min.js"></script>
</head>
<body>
<div id="main" style="width:500px ;height:500px;" ></div>
<script type="text/javascript">
var myCharts= echarts.init(document.getElementById("main"));
var data={
		//图形标题
		title:{
			text:"仪表图",
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
			        type: ['pie', 'bar']
			    }
			}
		},
		
	    //饼图数据
	    series: [{
	        name: '速度图',
	        title: {},
	        type: 'gauge',
	        min: 30,
	        max: 80,
	        data: [{value:75,name:"耗油量"}]
	        
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