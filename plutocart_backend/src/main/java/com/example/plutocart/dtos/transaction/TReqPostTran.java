package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class TReqPostTran {
    private Integer walletId;
    private String imageUrl;
    private BigDecimal stmTransaction;
    private Integer stmType;
    private String stmTypeString;
    private Integer transactionCategoryId;
}
