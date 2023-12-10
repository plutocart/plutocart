package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class TResPostDTO {
    private Integer transactionId;
    private Integer walletId;
    private BigDecimal stmTransaction;
    private Integer statementType;
    private String description;
}
