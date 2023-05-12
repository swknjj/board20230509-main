package com.icia.board.service;

import com.icia.board.dto.*;
import com.icia.board.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;

    public int memberSave(MemberDTO memberDTO) throws IOException {
        if(memberDTO.getMemberProfile().get(0).isEmpty()){
            memberDTO.setFileAttached(0);
            memberRepository.memberSave(memberDTO);
        }else {
            memberDTO.setFileAttached(1);
            MemberDTO dto = memberRepository.memberSave(memberDTO);
            for(MultipartFile memberFile : memberDTO.getMemberProfile()) {
                String originalFileName = memberFile.getOriginalFilename();
                String storedFileName = System.currentTimeMillis()+"-"+originalFileName;
                MemberprofileDTO memberprofileDTO = new MemberprofileDTO();
                memberprofileDTO.setOriginalFileName(originalFileName);
                memberprofileDTO.setStoredFileName(storedFileName);
                memberprofileDTO.setMemberId(dto.getId());
                String savePath = "D:\\signboard\\board\\" + storedFileName;
                memberFile.transferTo(new File(savePath));
                memberRepository.saveFile(memberprofileDTO);
            }
        }
        return 1;
    }

    public MemberDTO findByEmail(String email) {
        return memberRepository.findByEmail(email);
    }

    public MemberDTO memberLogin(MemberDTO memberDTO) {
        return memberRepository.memberLogin(memberDTO);
    }

    public List<MemberDTO> memberList(int page) {
        int pageLimit = 5;
        int pagingStart = (page - 1) * pageLimit;
        Map<String, Integer> pagingParams = new HashMap<>();
        pagingParams.put("start", pagingStart);
        pagingParams.put("limit", pageLimit);
        List<MemberDTO> memberDTOList = memberRepository.memberList(pagingParams);
        return memberDTOList;
    }

    public PageDTO pagingParam(int page) {
        // 한 페이지에 보여줄 글 갯수
        int pageLimit = 5;
        // 하단에 보여줄 페이지 번호 갯수
        int blockLimit = 5;
        // 전체 글 갯수 조회
        int memberCount = memberRepository.memberCount();
        // 전체 페이지 갯수 계산
        int maxPage = (int)(Math.ceil((double) memberCount / pageLimit));
        // 시작 페이지 계산
        int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
        // 마지막 페이지 값 계산
        int endPage = startPage + blockLimit - 1;
        // 전체 페이지 갯수가 계산한 endPage보다 작을때는 endPage를 maxPage와 같게 세팅
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }

    public List<MemberDTO> searchList(int page, String type, String q) {
        int pageLimit = 5;
        int pagingStart = (page-1)*pageLimit;
        Map<String, Object> pagingParams = new HashMap<>();
        pagingParams.put("start",pagingStart);
        pagingParams.put("limit",pageLimit);
        pagingParams.put("q",q);
        pagingParams.put("type",type);
        List<MemberDTO> memberDTOList = memberRepository.searchList(pagingParams);
        return memberDTOList;
    }

    public PageDTO pagingSearchParam(int page, String type, String q) {
        // 한 페이지에 보여줄 글 갯수
        int pageLimit = 5;
        // 하단에 보여줄 페이지 번호 갯수
        int blockLimit = 5;
        Map<String,Object> pagingParams = new HashMap<>();
        pagingParams.put("q",q);
        pagingParams.put("type",type);
        // 전체 글 갯수 조회
        int boardCount = memberRepository.memberSearchCount(pagingParams);
        // 전체 페이지 갯수 계산
        int maxPage = (int) (Math.ceil((double) boardCount / pageLimit));
        // 시작 페이지 계산
        int startPage = ((int) (Math.ceil((double) page / blockLimit))) * blockLimit - (blockLimit - 1);
        // 마지막 페이지 값 계산
        int endPage = startPage + blockLimit - 1;
        // 전체 페이지 갯수가 계산한 endPage보다 작을때는 endPage를 maxPage와 같게 세팅
        if (endPage > maxPage) {
            endPage = maxPage;
        }
        PageDTO pageDTO = new PageDTO();
        pageDTO.setPage(page);
        pageDTO.setMaxPage(maxPage);
        pageDTO.setEndPage(endPage);
        pageDTO.setStartPage(startPage);
        return pageDTO;
    }

    public List<MemberprofileDTO> findFile(Long id) {
        List<MemberprofileDTO> memberprofileDTOList = memberRepository.findFile(id);
        return memberprofileDTOList;
    }

    public void memberDelete(Long id) {
        memberRepository.memberDelete(id);
    }

    public void memberUpdate(MemberDTO memberDTO) throws IOException {
        if(memberDTO.getMemberProfile().get(0).isEmpty()) {
            memberDTO.setFileAttached(0);
            memberRepository.memberUpdate(memberDTO);
        }else {
            memberDTO.setFileAttached(1);
            memberRepository.memberUpdate(memberDTO);
            List<MemberprofileDTO> memberprofileDTOList = memberRepository.findFile(memberDTO.getId());
            if(memberprofileDTOList!=null) {
                memberRepository.fileDelete(memberDTO.getId());
            }
            for(MultipartFile memberFile : memberDTO.getMemberProfile()) {
                String originalFileName = memberFile.getOriginalFilename();
                String storedFileName = System.currentTimeMillis()+"-"+originalFileName;
                MemberprofileDTO memberprofileDTO = new MemberprofileDTO();
                memberprofileDTO.setOriginalFileName(originalFileName);
                memberprofileDTO.setStoredFileName(storedFileName);
                memberprofileDTO.setMemberId(memberDTO.getId());
                String savePath = "D:\\signboard\\board\\" + storedFileName;
                memberFile.transferTo(new File(savePath));
                memberRepository.saveFile(memberprofileDTO);
            }
        }
    }


    public MemberDTO findById(Long id) {
        MemberDTO memberDTO = memberRepository.findById(id);
        return memberDTO;
    }
}
