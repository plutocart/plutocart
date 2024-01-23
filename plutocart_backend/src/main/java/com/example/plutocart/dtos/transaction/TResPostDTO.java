package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class TResPostDTO {
    private Integer walletId;
    private Integer transactionId;
    private Integer transactionCategoryId;
    private String statementType;
    private BigDecimal stmTransaction;
    private String description;
}
