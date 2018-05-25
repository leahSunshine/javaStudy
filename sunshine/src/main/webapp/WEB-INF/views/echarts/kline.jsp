<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="/resources/echarts/echarts.min.js"></script>
<script type="text/javascript" src="/resources/echarts/jquery.min.js"></script>
<script type="text/javascript" src="/resources/echarts/echartsData.js"></script>
</head>
<body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 800px;height:600px;"></div>
<script type="text/javascript">
var data0 = splitData(klineData);
console.log(data0); 
var myChart = echarts.init(document.getElementById('main'));
var option={
	title:{
		text:'上证指数',
		left:'left'
	},
	tooltip:{
		trigger:'axis',
		axisPointer:{
			type:'shadow'
		}
	},
	legend:{
		data:['日K', 'MA5', 'MA10', 'MA20', 'MA30'],
		textStyle: {
            color: '#dd4444',
            fontSize: 16
        }
	},
	grid: {
        left: '10%',
        right: '10%',
        bottom: '15%'
    },
    xAxis: {
        type: 'category',
        data: data0.categoryData,
        scale: true,//只在数值轴中（type: 'value'）有效。
//         是否是脱离 0 值比例。设置成 true 后坐标刻度不会强制包含零刻度。在双数值轴的散点图中比较有用。
//         在设置 min 和 max 之后该配置项无效。
        boundaryGap : false,//坐标轴两边留白策略，类目轴和非类目轴的设置和表现不一样。
        axisLine: {onZero: false},
        splitLine: {show: false},
        splitNumber: 20,//在类目轴中无效。
        //坐标轴的分割段数，需要注意的是这个分割段数只是个预估值，最后实际显示的段数会在这个基础上根据分割后坐标轴刻度显示的易读程度作调整。
        min: 'dataMin',
        max: 'dataMax'
    },
    yAxis: {
        scale: true,
        splitArea: {
            show: true,
            interval:2
        }
    },
    //缩放
    dataZoom: [
        {
            type: 'inside',
            start: 50,//数据窗口的数据的起始百分比
            end: 100//结束百分比，数据展示50%-100%的数据
        },
        {
            show: true,
            type: 'slider',
            y: '90%',
            start: 50,
            end: 100
        }
    ],
    series: [
		{
		    name: '日K',
		    type: 'candlestick',
		    data: data0.values,
		    markPoint: {
		        label: {
		            normal: {
		                formatter: function (param) {
		                    return param != null ? Math.round(param.value) : '';
		                }
		            }
		        },
		        data: [
		            {
		                name: 'XX标点',
		                coord: ['2013/5/31', 2300],
		                value: 2300,
		                itemStyle: {
		                    normal: {color: 'rgb(41,60,85)'}
		                }
		            },
		            {
		                name: 'highest value',
		                type: 'max',
		                valueDim: 'highest'
		            },
		            {
		                name: 'lowest value',
		                type: 'min',
		                valueDim: 'lowest'
		            },
		            {
		                name: 'average value on close',
		                type: 'average',
		                valueDim: 'close'
		            }
		        ],
		        tooltip: {
		            formatter: function (param) {
		                return param.name + '<br>' + (param.data.coord || '');
		            }
		        }
		    },
		    markLine: {
                symbol: ['none', 'none'],
                data: [
                    [
                        {
                            name: 'from lowest to highest',
                            type: 'min',
                            valueDim: 'lowest',
                            symbol: 'circle',
                            symbolSize: 10,
                            label: {
                                normal: {show: false},
                                emphasis: {show: false}
                            }
                        },
                        {
                            type: 'max',
                            valueDim: 'highest',
                            symbol: 'circle',
                            symbolSize: 10,
                            label: {
                                normal: {show: false},
                                emphasis: {show: false}
                            }
                        }
                    ],
                    {
                        name: 'min line on close',
                        type: 'min',
                        valueDim: 'close'
                    },
                    {
                        name: 'max line on close',
                        type: 'max',
                        valueDim: 'close'
                    }
                ]
            }
        },
        {
            name: 'MA5',
            type: 'line',
            data: calculateMA(5),
            smooth: true,
            lineStyle: {
                normal: {opacity: 0.5}
            }
        },
        {
            name: 'MA10',
            type: 'line',
            data: calculateMA(10),
            smooth: true,
            lineStyle: {
                normal: {opacity: 0.5}
            }
        },
        {
            name: 'MA20',
            type: 'line',
            data: calculateMA(20),
            smooth: true,
            lineStyle: {
                normal: {opacity: 0.5}
            }
        },
        {
            name: 'MA30',
            type: 'line',
            data: calculateMA(30),
            smooth: true,
            lineStyle: {
                normal: {opacity: 0.5}
            }
        }
		   
		
     ]
};
myChart.setOption(option);

//定义一个数组分割的函数，用于将一个数组分割为2个数组
function splitData(rawData) {
 var categoryData = [];
 var values = [];
 for (var i = 0; i < rawData.length; i++) {
     categoryData.push(rawData[i].splice(0, 1)[0]);//从第0项开始，删除一项，返回删除的哪一项，并且原数组删除一项。
     values.push(rawData[i])
 }
 return {
     categoryData: categoryData,//返回的json数据
     values: values
 };
};
 console.log(calculateMA(5));
 function calculateMA(dayCount) {
     var result = [];
     for (var i = 0, len = data0.values.length; i < len; i++) {
         if (i < dayCount) {
             result.push('-');
             continue;
         }
         var sum = 0;
         for (var j = 0; j < dayCount; j++) {
             sum += data0.values[i - j][1];
         }
         result.push(sum / dayCount);
     }
     return result;
 };





</script>
</body>
</html>