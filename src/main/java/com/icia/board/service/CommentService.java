package com.icia.board.service;

import com.icia.board.dto.CommentDTO;
import com.icia.board.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    @Autowired
    CommentRepository commentRepository;

    public void save(CommentDTO commentDTO) {
        commentRepository.save(commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId) {
        List<CommentDTO> commentDTOList = commentRepository.findAll(boardId);
        return commentDTOList;
    }
}
