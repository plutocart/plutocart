package com.example.plutocart.dtos.transaction;

import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;
import java.time.Instant;

@Getter
@Setter
public class TResPostDTO {
    private Integer transactionId;
    private Integer wId;
    private BigDecimal stmTransaction;
    private String statementType;
    private String description;
}
