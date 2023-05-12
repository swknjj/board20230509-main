package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.MemberDTO;
import com.icia.board.dto.MemberprofileDTO;
import com.icia.board.dto.PageDTO;
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
public class MemberController {
    @Autowired
    MemberService memberService;

    // 회원가입 데이터 전달
    @PostMapping("/member/save")
    public String memberSave(@ModelAttribute MemberDTO memberDTO) throws IOException {
        int result = memberService.memberSave(memberDTO);
        if (result == 1) {
            return "redirect:/board/boardList";
        } else {
            return "/response/saveErrorPage";
        }
    }

    // 멤버 로그인
    @PostMapping("/member/login")
    public String memberLogin(@ModelAttribute MemberDTO memberDTO, HttpSession session) {
        MemberDTO member = memberService.memberLogin(memberDTO);
        if(member != null){
            session.setAttribute("loginEmail",memberDTO.getMemberEmail());
            return "redirect:/board/boardList";
        }else {
            return "/response/loginErrorPage";
        }
    }

    // 로그아웃
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "/response/logout";

    }

    // 페이징 처리된 멤버리스트
    @GetMapping("/member/memberList")
    public String boardList(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
                            @RequestParam(value = "q", required = false, defaultValue = "") String q,
                            @RequestParam(value = "type", required = false, defaultValue = "id") String type,
                            @RequestParam(value = "memberId", required = false, defaultValue = "") Long id, Model model, HttpSession session) {
        List<MemberDTO> memberDTOList = null;
        PageDTO pageDTO = null;
        if(q.equals("")){
            memberDTOList = memberService.memberList(page);
            pageDTO = memberService.pagingParam(page);
        }else {
            memberDTOList = memberService.searchList(page,type,q);
            pageDTO = memberService.pagingSearchParam(page,type,q);
        }
        if(session.getAttribute("loginEmail")!=null) {
            String loginEmail = (String) session.getAttribute("loginEmail");
            MemberDTO memberDTO = memberService.findByEmail(loginEmail);
            id = memberDTO.getId();
            model.addAttribute("memberList", memberDTOList);
            model.addAttribute("paging", pageDTO);
            model.addAttribute("q", q);
            model.addAttribute("type", type);
            model.addAttribute("memberId", id);
        }else {
            id = null;
            model.addAttribute("memberList", memberDTOList);
            model.addAttribute("paging", pageDTO);
            model.addAttribute("q", q);
            model.addAttribute("type", type);
            model.addAttribute("memberId", id);
        }
        System.out.println(pageDTO);
        return "/memberPages/memberList";
    }

    // 내 정보 페이지로
    @GetMapping("/member/mypage")
    public String myPageForm(@ModelAttribute MemberDTO memberDTO,HttpSession session,Model model) {
        String loginEmail = (String) session.getAttribute("loginEmail");
        MemberDTO LoginDTO = memberService.findByEmail(loginEmail);
            List<MemberprofileDTO> memberprofileDTOList = memberService.findFile(LoginDTO.getId());
            model.addAttribute("LoginDTO",LoginDTO);
            model.addAttribute("memberprofileDTO",memberprofileDTOList);
        return "/memberPages/memberMyPage";
    }
    @GetMapping("/member/delete")
    public String memberDelete(@RequestParam("id") Long id) {
        memberService.memberDelete(id);
        return "redirect:/member/memberList";
    }
    @PostMapping("/member/update")
    public String memberUpdate(@ModelAttribute MemberDTO memberDTO, HttpSession session,Model model) throws IOException {
        System.out.println("memberDTO"+memberDTO);
        memberService.memberUpdate(memberDTO);
        session.setAttribute("loginEmail",memberDTO.getMemberEmail());
        MemberDTO dto = memberService.findById(memberDTO.getId());
        List<MemberprofileDTO> memberprofileDTOList = memberService.findFile(memberDTO.getId());
        model.addAttribute("memberprofileDTO",memberprofileDTOList);
        model.addAttribute("LoginDTO",dto);
        System.out.println(memberDTO);
        return "/memberPages/memberMyPage";
    }
    @GetMapping("/member/outing")
    public String memberOuting(@RequestParam("id")Long id,HttpSession session) {
        memberService.memberDelete(id);
        session.invalidate();
        return "/index";
    }
}

