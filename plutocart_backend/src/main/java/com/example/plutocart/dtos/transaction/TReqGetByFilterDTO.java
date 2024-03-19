package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TReqGetByFilterDTO {
    private Integer accountId;
    private Integer walletId;
    private Integer month;
    private Integer year;
}
