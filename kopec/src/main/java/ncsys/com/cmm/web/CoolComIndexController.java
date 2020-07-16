package ncsys.com.cmm.web;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CoolComIndexController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CoolComIndexController.class);


	@RequestMapping("/index.do")
	public String index(ModelMap model) {

		System.out.println("IndexController :");

		return "main/portal.tiles";
	}

}
