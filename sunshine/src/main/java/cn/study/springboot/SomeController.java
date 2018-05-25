package cn.study.springboot;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SomeController {
	@RequestMapping("index")
    public ModelAndView index(){
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName("index");;
        return mv;
    }
	@RequestMapping("d3/histogram")
	public ModelAndView histogram(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("d3/histogram");;
		return mv;
	}
	
	@RequestMapping("d3/polyline")
	public ModelAndView polyline(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("d3/polyline");;
		return mv;
	}
	@RequestMapping("d3/pie")
	public ModelAndView pie(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("d3/pie");;
		return mv;
	}
	@RequestMapping("d3/spot")
	public ModelAndView spot(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("d3/spot");;
		return mv;
	}
	@RequestMapping("echarts/helloword")
	public ModelAndView helloword(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("echarts/helloword");;
		return mv;
	}
	@RequestMapping("echarts/pie")
	public ModelAndView pie1(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("echarts/pie");;
		return mv;
	}
	@RequestMapping("echarts/gauge")
	public ModelAndView gauge(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("echarts/gauge");;
		return mv;
	}
	@RequestMapping("echarts/geo1")
	public ModelAndView geo1(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("echarts/geo1");;
		return mv;
	}
	@RequestMapping("echarts/scatter")
	public ModelAndView scatter(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("echarts/scatter");;
		return mv;
	}
	@RequestMapping("echarts/kline")
	public ModelAndView kline(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("echarts/kline");;
		return mv;
	}
	
	@RequestMapping("echarts/radar")
	public ModelAndView radar(){
		ModelAndView mv = new ModelAndView();
		mv.setViewName("echarts/radar");;
		return mv;
	}
	
}
