package com.icia.board.repository;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BoardRepository {
    @Autowired
    private SqlSessionTemplate sql;


    public BoardDTO boardSave(BoardDTO boardDTO) {
        sql.insert("Board.boardSave",boardDTO);
        return boardDTO;
    }

    public List<BoardDTO> boardList(Map<String, Integer> pagingParams) {
        return sql.selectList("Board.boardList",pagingParams);
    }

    public int boardCount() {
        return sql.selectOne("Board.boardCount");
    }

    public List<BoardDTO> searchList(Map<String, Object> pagingParams) {
        return sql.selectList("Board.search",pagingParams);
    }

    public int boardSearchCount(Map<String, Object> pagingParams) {
        return sql.selectOne("Board.boardSearchCount",pagingParams);
    }

    public BoardDTO boardDetail(Long boardId) {
        return sql.selectOne("Board.boardDetail",boardId);
    }

    public void increase(Long boardId) {
        sql.update("Board.increase",boardId);
    }

    public void saveFile(BoardFileDTO boardFileDTO) {
        sql.insert("Board.saveFile",boardFileDTO);
    }

    public void boardDelete(Long boardid) {
        sql.delete("Board.boardDelete",boardid);
    }

    public List<BoardFileDTO> findFile(Long id) {
        return sql.selectList("Board.findFile",id);
    }

    public BoardDTO findById(Long id) {
        return sql.selectOne("Board.findById",id);
    }

    public void boardUpdate(BoardDTO dto) {
        sql.update("Board.boardUpdate",dto);
    }

    public void fileDelete(Long id) {
        sql.delete("Board.fileDelete",id);
    }
}
