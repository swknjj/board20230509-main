package com.icia.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberprofileDTO {
    Long id;
    String OriginalFileName;
    String storedFileName;
    Long memberId;
}
