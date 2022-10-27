package egovframework.example.board.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {
	
	@RequestMapping(value = "/list.do")
	public String getList(){
		return "eGovBoard/list";
	}
	
}