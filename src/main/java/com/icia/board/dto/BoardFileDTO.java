package com.icia.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardFileDTO {
    Long id;
    String originalFileName;
    String storedFileName;
    Long boardId;

}
