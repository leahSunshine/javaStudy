<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resources/echarts/echarts.min.js"></script>
<script type="text/javascript" src="/resources/echarts/china.js"></script>
</head>
<body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 1000px;height:1000px;"></div>
<script type="text/javascript">
var myChart = echarts.init(document.getElementById('main'));
var option = {
	    title : {
	        text: 'iphone销量',
	        subtext: '纯属虚构',
	        left: 'center'
	    },
	    //提示组件
	    tooltip : {
	        trigger: 'item'//数据项触发
	    },
	    //图例组件
	    legend: {
	        orient: 'vertical',//布局朝向默认是水平的，这里设置为垂直的
	        left: 'left',
	        data:['iphone3','iphone4','iphone5']//这里的数据必须和series的name保持一致
	    },
	    //视觉映射组件
	    visualMap: {
	        min: 0,
	        max: 2500,
	        left: 'left',
	        top: 'bottom',
	        text:['高','低'],           // 文本，默认为数值文本
	        calculable : true
	    },
	    //工具栏
	    toolbox: {
	        show: true,
	        orient : 'vertical',
	        left: 'right',
	        top: 'center',
	        feature : {
	            dataView : {show: true, readOnly: false},
	            restore : {show: true},
	            saveAsImage : {show: true}
	        }
	    },
	    series : [
	        {
	            name: 'iphone3',
	            type: 'map',
	            map: 'china',
	            roam: true,//是否开启鼠标缩放和平移漫游。默认不开启false
	            label: {//地图上的标签，不是提示信息
	                emphasis: {
	                    show: true,
	                    formatter:'{b}: {c}'
	                }
	            },  
	            data:[
	                {name: '北京',value: Math.round(Math.random()*1000)},
	                {name: '天津',value: Math.round(Math.random()*1000)},
	                {name: '上海',value: Math.round(Math.random()*1000)},
	                {name: '重庆',value: Math.round(Math.random()*1000)},
	                {name: '河北',value: Math.round(Math.random()*1000)},
	                {name: '河南',value: Math.round(Math.random()*1000)},
	                {name: '云南',value: Math.round(Math.random()*1000)},
	                {name: '辽宁',value: Math.round(Math.random()*1000)},
	                {name: '黑龙江',value: Math.round(Math.random()*1000)},
	                {name: '湖南',value: Math.round(Math.random()*1000)},
	                {name: '安徽',value: Math.round(Math.random()*1000)},
	                {name: '山东',value: Math.round(Math.random()*1000)},
	                {name: '新疆',value: Math.round(Math.random()*1000)},
	                {name: '江苏',value: Math.round(Math.random()*1000)},
	                {name: '浙江',value: Math.round(Math.random()*1000)},
	                {name: '江西',value: Math.round(Math.random()*1000)},
	                {name: '湖北',value: Math.round(Math.random()*1000)},
	                {name: '广西',value: Math.round(Math.random()*1000)},
	                {name: '甘肃',value: Math.round(Math.random()*1000)},
	                {name: '山西',value: Math.round(Math.random()*1000)},
	                {name: '内蒙古',value: Math.round(Math.random()*1000)},
	                {name: '陕西',value: Math.round(Math.random()*1000)},
	                {name: '吉林',value: Math.round(Math.random()*1000)},
	                {name: '福建',value: Math.round(Math.random()*1000)},
	                {name: '贵州',value: Math.round(Math.random()*1000)},
	                {name: '广东',value: Math.round(Math.random()*1000)},
	                {name: '青海',value: Math.round(Math.random()*1000)},
	                {name: '西藏',value: Math.round(Math.random()*1000)},
	                {name: '四川',value: Math.round(Math.random()*1000)},
	                {name: '宁夏',value: Math.round(Math.random()*1000)},
	                {name: '海南',value: Math.round(Math.random()*1000)},
	                {name: '台湾',value: Math.round(Math.random()*1000)},
	                {name: '香港',value: Math.round(Math.random()*1000)},
	                {name: '澳门',value: Math.round(Math.random()*1000)}
	            ]
	        },
	        {
	            name: 'iphone4',
	            type: 'map',
	            map: 'china',
	            data:[
	                {name: '北京',value: Math.round(Math.random()*1000)},
	                {name: '天津',value: Math.round(Math.random()*1000)},
	                {name: '上海',value: Math.round(Math.random()*1000)},
	                {name: '重庆',value: Math.round(Math.random()*1000)},
	                {name: '河北',value: Math.round(Math.random()*1000)},
	                {name: '安徽',value: Math.round(Math.random()*1000)},
	                {name: '新疆',value: Math.round(Math.random()*1000)},
	                {name: '浙江',value: Math.round(Math.random()*1000)},
	                {name: '江西',value: Math.round(Math.random()*1000)},
	                {name: '山西',value: Math.round(Math.random()*1000)},
	                {name: '内蒙古',value: Math.round(Math.random()*1000)},
	                {name: '吉林',value: Math.round(Math.random()*1000)},
	                {name: '福建',value: Math.round(Math.random()*1000)},
	                {name: '广东',value: Math.round(Math.random()*1000)},
	                {name: '西藏',value: Math.round(Math.random()*1000)},
	                {name: '四川',value: Math.round(Math.random()*1000)},
	                {name: '宁夏',value: Math.round(Math.random()*1000)},
	                {name: '香港',value: Math.round(Math.random()*1000)},
	                {name: '澳门',value: Math.round(Math.random()*1000)}
	            ]
	        },
	        {
	            name: 'iphone5',
	            type: 'map',
	            map: 'china',
	            data:[
	                {name: '北京',value: Math.round(Math.random()*1000)},
	                {name: '天津',value: Math.round(Math.random()*1000)},
	                {name: '上海',value: Math.round(Math.random()*1000)},
	                {name: '广东',value: Math.round(Math.random()*1000)},
	                {name: '台湾',value: Math.round(Math.random()*1000)},
	                {name: '香港',value: Math.round(Math.random()*1000)},
	                {name: '澳门',value: Math.round(Math.random()*1000)}
	            ]
	        }
	    ]
	};

myChart.setOption(option);
/* myChart.on('mouseover', function (params) {
    var dataIndex = params.dataIndex;
    console.log(params);
}); */
</script>
</body>
</html>