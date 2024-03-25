package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class TReqPostTran {
    private Integer accountId;
    private Integer walletId;
    private Integer transactionId;
    private String imageUrl;
    private BigDecimal stmTransaction;
    private Integer stmType;
    private String stmTypeString;
    private Integer transactionCategoryId;
    private Integer goalId;
    private Integer debtId;
}
