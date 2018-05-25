package cn.study.springboot;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class SomeController {
	@RequestMapping("hello")
    public ModelAndView hello(){
		 ModelAndView mv = new ModelAndView();
		 mv.setViewName("cart");;
        return mv;
    }
}
