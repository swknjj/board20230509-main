package com.icia.board.controller;

import com.icia.board.dto.MemberDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class HomeController {
    // 인덱스로
    @GetMapping("/")
    public String index() {
        return "index";
    }

    // 회원가입 창으로 이동
    @GetMapping("/member/Save")
    public String memberSaveForm() {
        return "/memberPages/memberSave";
    }

    // 로그인페이지로
    @GetMapping("/member/Login")
    public String memberLoginForm() {
        return "/memberPages/memberLogin";
    }



//    // 멤버리스트 페이지로
//    @GetMapping("/member/memberList")
//    public String memberList() {
//        return "/memberPages/memberList";
//    }

}
