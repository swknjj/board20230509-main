package com.icia.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Setter
@Getter
@ToString

public class CommentDTO {
    Long id;
    Long boardId;
    Long memberId;
    String commentWriter;
    String commentContents;
    Timestamp commentCreatedDate;
}
