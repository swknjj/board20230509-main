package com.icia.board.controller;

import com.icia.board.dto.*;
import com.icia.board.service.BoardService;
import com.icia.board.service.CommentService;
import com.icia.board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
public class BoardController {
    @Autowired
    BoardService boardService;
    @Autowired
    MemberService memberService;
    @Autowired
    CommentService commentService;

    // 글 작성 페이지로
    @GetMapping("/board/Save")
    public String boardSaveForm(HttpSession session, Model model, MemberDTO memberDTO) {
        String email = (String) session.getAttribute("loginEmail");
        MemberDTO dto = memberService.findByEmail(email);
        if (email != null) {
            model.addAttribute("member", dto);
        } else {
            model.addAttribute("member", "");
        }
        return "/boardPages/boardSave";
    }

    @PostMapping("/board/Save")
    public String boardSave(@ModelAttribute BoardDTO boardDTO, HttpSession session) throws Exception {
        String loginEmail = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.findByEmail(loginEmail);
        if (memberDTO != null) {
            boardService.boardSave(boardDTO);
            return "redirect:/board/boardList";
        } else {
            return "/response/errorPage";
        }
    }

    @GetMapping("/board/boardList")
    public String boardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                            @RequestParam(value = "q", required = false, defaultValue = "") String q,
                            @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                            @RequestParam(value = "memberId", required = false, defaultValue = "") Long id, Model model, HttpSession session) {
        List<BoardDTO> boardDTOList = null;
        PageDTO pageDTO = null;
        if (q.equals("")) {
            boardDTOList = boardService.boardList(page);
            pageDTO = boardService.pagingParam(page);
        } else {
            boardDTOList = boardService.searchList(page, type, q);
            pageDTO = boardService.pagingSearchParam(page, type, q);
        }
        if (session.getAttribute("loginEmail") != null) {
            String loginEmail = (String) session.getAttribute("loginEmail");
            MemberDTO memberDTO = memberService.findByEmail(loginEmail);
            id = memberDTO.getId();
            model.addAttribute("boardList", boardDTOList);
            model.addAttribute("paging", pageDTO);
            model.addAttribute("q", q);
            model.addAttribute("type", type);
            model.addAttribute("memberId", id);
        } else {
            id = null;
            model.addAttribute("boardList", boardDTOList);
            model.addAttribute("paging", pageDTO);
            model.addAttribute("q", q);
            model.addAttribute("type", type);
            model.addAttribute("memberId", id);

        }
        return "/boardPages/boardList";
    }

    @GetMapping("/board/detail")
    public String boardDetail(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                              @RequestParam(value = "q", required = false, defaultValue = "") String q,
                              @RequestParam(value = "type", required = false, defaultValue = "boardTitle") String type,
                              @ModelAttribute BoardDTO boardDTO, Model model, PageDTO pageDTO, HttpSession session) {
        boardService.increase(boardDTO.getId());
        BoardDTO dto = boardService.boardDetail(boardDTO.getId());
        List<BoardFileDTO> boardFileDTOList = boardService.findFile(boardDTO.getId());
        model.addAttribute("boardFileDTO", boardFileDTOList);
        List<CommentDTO> commentDTOList = commentService.findAll(boardDTO.getId());
        model.addAttribute("commentList", commentDTOList);
        if (q.equals("")) {
            pageDTO = boardService.pagingParam(page);
        } else {
            pageDTO = boardService.pagingSearchParam(page, type, q);
        }
        model.addAttribute("paging", pageDTO);
        model.addAttribute("q", q);
        model.addAttribute("type", type);
        model.addAttribute("BoardDTO", dto);
        model.addAttribute("page", page);
        return "/boardPages/boardDetail";
    }

    @GetMapping("/board/delete")
    public String boardDelete(@RequestParam("id") Long boardId) {
        boardService.boardDelete(boardId);
        return "redirect:/board/boardList";
    }
    // 글 수정 페이지로
    @GetMapping("/board/update")
    public String boardUpdateForm(@ModelAttribute BoardDTO boardDTO,Model model) {
        BoardDTO dto = boardService.findById(boardDTO.getId());
        List<BoardFileDTO> boardFileDTOList = boardService.findFile(boardDTO.getId());
//        boardService.boardUpdate(dto);
        model.addAttribute("boardDTO",dto);
        model.addAttribute("boardFileDTO",boardFileDTOList);
        return "/boardPages/boardUpdate";
    }

    @PostMapping("/board/update")
    public String boardUpdate(@ModelAttribute BoardDTO boardDTO) throws IOException {
        boardService.boardUpdate(boardDTO);
        return "redirect:/board/boardList";
    }



}
