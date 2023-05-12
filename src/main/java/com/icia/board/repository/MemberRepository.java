package com.icia.board.repository;

import com.icia.board.dto.MemberDTO;
import com.icia.board.dto.MemberprofileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class MemberRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public MemberDTO memberSave(MemberDTO memberDTO) {
        sql.insert("Member.memberSave",memberDTO);
        return memberDTO;
    }

    public MemberDTO findByEmail(String email) {
        return sql.selectOne("Member.findByEmail",email);
    }

    public MemberDTO memberLogin(MemberDTO memberDTO) {
        return sql.selectOne("Member.memberLogin",memberDTO);
    }

    public void saveFile(MemberprofileDTO memberprofileDTO) {
        sql.insert("Member.saveFile",memberprofileDTO);

    }

    public List<MemberDTO> memberList(Map<String, Integer> pagingParams) {
        return sql.selectList("Member.memberList",pagingParams);
    }

    public int memberCount() {
        return sql.selectOne("Member.memberCount");
    }

    public List<MemberDTO> searchList(Map<String, Object> pagingParams) {
        return sql.selectList("Member.search",pagingParams);
    }

    public int memberSearchCount(Map<String, Object> pagingParams) {
        return sql.selectOne("Member.searchCount",pagingParams);
    }

    public List<MemberprofileDTO> findFile(Long id) {
        return sql.selectList("Member.findFile",id);
    }

    public void memberDelete(Long id) {
        sql.delete("Member.memberDelete",id);
    }

    public void memberUpdate(MemberDTO memberDTO) {
        sql.update("Member.memberUpdate",memberDTO);
    }

    public MemberDTO findById(Long id) {
        return sql.selectOne("Member.findById",id);

    }

    public void fileDelete(Long id) {
        sql.delete("Member.fileDelete",id);
    }
}
