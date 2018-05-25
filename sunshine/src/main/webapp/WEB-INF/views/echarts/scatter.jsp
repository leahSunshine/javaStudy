<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resources/echarts/echarts.min.js"></script>
<script type="text/javascript" src="/resources/echarts/jquery.min.js"></script>
</head>
<body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 800px;height:600px;"></div>
<script type="text/javascript">

var myChart = echarts.init(document.getElementById('main'));
var dataBJ=[];
var dataGZ=[];
var dataSH=[];
var schema = [];
var itemStyle ;
$.getJSON("/resources/echarts/echarts.json", function(data,status) {
//能通过json解析的数据的（使用$.getJSON和$.parseJSON），key和value都需要使用双引号
//如果直接是一个对象，可以按照下面的方式定义
// 	data = $.parseJSON(data);
	   dataBJ=data.dataBJ;
	   dataGZ=data.dataGZ;
	   dataSH=data.dataSH;
	   schema =data.schema;
	   itemStyle = data.itemStyle;
var option = {
		backgroundColor:'#333',//背景色
		color: [
		        '#dd4444', '#fec42c', '#80F1BE'//调色盘颜色列表，有默认的一些数据
		    ],
		 legend:{//图例
			 y: 'top',
		        data: ['北京', '上海', '广州'],
		        textStyle: {
		            color: '#fff',
		            fontSize: 16
		        }
		 },
		 //网格
		 grid: {
		        x: '10%',
		        x2: 150,
		        y: '18%',
		        y2: '10%'
		    },
		 //提示信息
		 tooltip:{
			padding: 10,
	        backgroundColor: '#222',
	        borderColor: '#777',
	        borderWidth: 1,
	        formatter: function (obj) {
	            var value = obj.value;
	            return '<div style="border-bottom: 1px solid rgba(255,255,255,.3); font-size: 18px;padding-bottom: 7px;margin-bottom: 7px">'
	                + obj.seriesName + ' ' + value[0] + '日：'
	                + value[7]
	                + '</div>'
	                + schema[1].text + '：' + value[1] + '<br>'
	                + schema[2].text + '：' + value[2] + '<br>'
	                + schema[3].text + '：' + value[3] + '<br>'
	                + schema[4].text + '：' + value[4] + '<br>'
	                + schema[5].text + '：' + value[5] + '<br>'
	                + schema[6].text + '：' + value[6] + '<br>';
	        }
		 },
		 //x坐标
		 xAxis: {
		        type: 'value',//坐标轴为连续的数值型，默认为category类目轴，适合离散型的数据，必须设置data
		        name: '日期',//坐标轴名称
		        nameGap: 16,//坐标轴与名称的距离，默认15
		        nameTextStyle: {
		            color: '#fff',
		            fontSize: 14
		        },
		        max: 31,
		        splitLine: {//坐标轴在网格线中的分割线
		            show: false
		        },
		        axisLine: {//坐标轴线
		            lineStyle: {
		                color: '#777'
		            }
		        },
		        axisTick: {//坐标轴刻度
		            lineStyle: {
		                color: '#777'
		            }
		        },
		        axisLabel: {//坐标轴刻度标签
		            formatter: '{value}',
		            textStyle: {
		                color: '#fff'
		            }
		        }
		    },
		    //y坐标轴
		    yAxis: {
		        type: 'value',
		        name: 'AQI指数',
		        nameLocation: 'end',
		        nameGap: 20,
		        nameTextStyle: {
		            color: '#fff',
		            fontSize: 16
		        },
		        axisLine: {
		            lineStyle: {
		                color: '#777'
		            }
		        },
		        axisTick: {
		            lineStyle: {
		                color: '#777'
		            }
		        },
		        splitLine: {
		            show: false
		        },
		        axisLabel: {
		            textStyle: {
		                color: '#fff'
		            }
		        }
		    },
		    //视觉映射组件
		    visualMap: [
                {
                    left: 'right',
                    top: '10%',
                    dimension: 2,//取数据的第3列，映射到该视觉组件上面，也就是PM25
                    min: 0,
                    max: 250,
                    itemWidth: 30,
                    itemHeight: 120,
                    calculable: true,//是否显示拖拽用的手柄
                    precision: 0.1,//数据展示的小数精度
                    text: ['圆形大小：PM2.5'],//两端的文本
                    textGap: 30,//文本间距
                    textStyle: {
                        color: '#fff'
                    },
                    inRange: {//定义 在选中范围中 的视觉元素。
                        symbolSize: [10, 70]
                    },
                    outOfRange: {//定义 在选中范围外 的视觉元素
                        symbolSize: [10, 70],
                        color: ['rgba(255,255,255,.2)']
                    },
                    controller: {//不是太明白
                        inRange: {
                            color: ['#c23531']
                        },
                        outOfRange: {
                            color: ['#444']
                        }
                    }
                },
                {
                    left: 'right',
                    bottom: '5%',
                    dimension: 6,//SO2
                    min: 0,
                    max: 50,
                    itemHeight: 120,
                    calculable: true,
                    precision: 0.1,
                    text: ['明暗：二氧化硫'],
                    textGap: 30,
                    textStyle: {
                        color: '#fff'
                    },
                    inRange: {
                        colorLightness: [1, 0.5]
                    },
                    outOfRange: {
                        color: ['rgba(255,255,255,.2)']
                    },
                    controller: {
                        inRange: {
                            color: ['#c23531']
                        },
                        outOfRange: {
                            color: ['#444']
                        }
                    }
                }
		      ],
		      series: [
               {
                   name: "北京",
                   type: 'scatter',
                   itemStyle: itemStyle,
                   data: dataBJ
               },
               {
                   name: "上海",
                   type: 'scatter',
                   itemStyle: itemStyle,
                   data: dataSH
               },
               {
                   name: "广州",
                   type: 'scatter',
                   itemStyle:itemStyle,
                   data: dataGZ
               }
           ]
	};
/* $.get('./echarts.json').done(function (data) {  
	console.log("1"); 
    console.log(data);  
    dataBJ=data.dataBJ;
    dataGZ=data.dataBJ;
    dataSH=data.dataBJ;
    schema =data.dataBJ;
    itemStyle = data.dataBJ;
    myChart.setOption(option);
});  */ 

   console.log(itemStyle);  
   myChart.setOption(option);
   console.log(option.leng);
});


/* myChart.on('mouseover', function (params) {
    var dataIndex = params.dataIndex;
    console.log(params);
}); */
</script>
</body>
</html>