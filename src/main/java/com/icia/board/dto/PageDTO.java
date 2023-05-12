package com.icia.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {
    // 현재 페이지
    private int page;
    // 전체 페이지 개수
    private int maxPage;
    // 하단에 보여지는 시작 페이지 번호
    private int startPage;
    // 하단에 보여지는 마지막 페이지 번호
    private int endPage;


}
