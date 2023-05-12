package com.icia.board.controller;

import com.icia.board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.icia.board.dto.MemberDTO;

@Controller
public class ajaxController {
    @Autowired
    MemberService memberService;

    // 이메일 중복체크 ajax
    @PostMapping("email-check")
    public ResponseEntity emailCheck(@RequestParam("email_check") String email) {
        MemberDTO memberDTO = memberService.findByEmail(email);
        if(memberDTO == null) {
            return new ResponseEntity<>(memberDTO, HttpStatus.OK);
        }else {
            return new ResponseEntity<>(memberDTO, HttpStatus.CONFLICT);
        }
    }


}
