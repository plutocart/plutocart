package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Getter
@Setter
public class TransactionPostDTO {
    private Integer walletId;
    private BigDecimal stmTransaction;
    private String statementType;
}
