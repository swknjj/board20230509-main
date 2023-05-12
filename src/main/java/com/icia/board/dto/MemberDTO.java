package com.icia.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@ToString

public class MemberDTO {
    Long id;
    String memberEmail;
    String memberPassword;
    String memberName;
    String memberMobile;
    int fileAttached;
    List<MultipartFile> memberProfile;
}
