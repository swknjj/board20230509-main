package com.icia.board.controller;

import com.icia.board.dto.CommentDTO;
import com.icia.board.dto.MemberDTO;
import com.icia.board.service.CommentService;
import com.icia.board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CommentController {
    @Autowired
    CommentService commentService;
    @Autowired
    MemberService memberService;

    @PostMapping("/comment/save")
    public ResponseEntity save(@ModelAttribute CommentDTO commentDTO, HttpSession session) {
        MemberDTO memberDTO = memberService.findByEmail((String)session.getAttribute("loginEmail"));
        commentDTO.setMemberId(memberDTO.getId());
        commentService.save(commentDTO);
        List<CommentDTO> commentDTOList = commentService.findAll(commentDTO.getBoardId());
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }


}
