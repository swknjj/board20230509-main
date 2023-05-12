package com.icia.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
import java.util.List;

@Setter
@Getter
@ToString

public class BoardDTO {
    Long id;
    String boardTitle;
    String boardWriter;
    String boardContents;
    int boardHits;
    Timestamp boardCreatedDate;
    int fileAttached;
    int memberId;
    List<MultipartFile> boardProfile;
}
