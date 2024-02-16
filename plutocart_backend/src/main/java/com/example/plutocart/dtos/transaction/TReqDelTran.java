package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
public class TReqDelTran {
    private Integer accountId;
    private Integer walletId;
    private Integer transactionId;
    private BigDecimal stmTransaction;
    private String stmType;
    private Integer goalId;
    private Integer debtId;
    private LocalDateTime transactionDate;
}
